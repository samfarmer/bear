<cfsetting enablecfoutputonly="true">
<cfscript>
param name="url.startEntity" default=""; 
param name="url.excludeEntities" default="";
param name="url.isRelationshipsOnly" default="false";
variables.depth = 0;
bear = new services.bear();

allEntityNames = bear.getAllEntityNames();

function display( entity ) {
	//entity can be a full path, especially when defined in relationships, and we want to only get the last part
	entity = listLast( entity, "." );
	var properties = getMetadata( entityNew( entity ) ).properties;
	var offset = ( depth > 0 ) ? (depth*2): 0;
	excludeEntities = listAppend( excludeEntities, entity );
	
	var propertyDetails = "";
	var aProp = "";
	var br = "";

	for ( var i = 1; i <=  arrayLen( properties ); i++ ) {
		var prop = properties[ i ];
		
		propertyDetails = "";
		br = "";
		for ( aProp in prop ) {
			if ( aProp != "name" ) {
				propertyDetails &= br & aProp & ": " & prop[ aProp ];
				br = "<br>";
			}
		}
		
		if ( structKeyExists( prop, "fieldtype" ) && prop.fieldtype != "id" ) {
			writeOutput('<div class="row-fluid">
							<div class="offset#offset# span2 hasPopover" data-content="#propertyDetails#" data-original-title="#entity#.#prop.name#"><span class="label label-#(prop.fieldtype eq 'many-to-one') ? 'info':'success'#">#prop.name#</span></div>
							<div class="span2"><span class="labeld">#prop.fieldtype#</span></div>
						</div>');
			writeOutput('<div class="row-fluid">
							<div class="offset#offset# span2"></div>
							<div class="span2"><span class="label label-important">#listLast( prop.cfc, "." )#</span></div>
						</div>');
			if ( ! listFindNoCase( excludeEntities, listLast( prop.cfc, "." ) ) && depth < 3 ) {
				depth++;
				display( listLast( prop.cfc, "." ) );
			} else {
				writeOutput('<div class="row-fluid">
								<div class="offset#offset+2# span2"><em>Not displayed</em></div>
							</div>');
			}
		} else if ( ! url.isRelationshipsOnly ) {
			writeOutput('<div class="row-fluid">
							<div class="offset#offset# span2 hasPopover" data-content="#propertyDetails#" data-original-title="#entity#.#prop.name#">#prop.name#</div>
						</div>');
		}
	}

	if ( depth > 0 ) {
		depth--;
	}
	
}

</cfscript>

<cfinclude template="ui/header.cfm">

<cfoutput>
    	
    	<script>
    	$(document).ready( function() {
    		$(".hasPopover").popover( { placement: "top", trigger: "hover", delay: { show: 500, hide: 100 } } );
		})
    	</script>
    	
    	
    	<h1>bear</h1>

		<form action="index.cfm" method="get">
		
		<div class="row-fluid well well-small">
			<div class="span3">
				<label>Start Entity (#arrayLen( allEntityNames )#)</label>
				<select name="startEntity" size="5">
					<cfloop array="#allEntityNames#" index="entity"><option #(url.startEntity eq entity)?"selected":""#>#entity#</option></cfloop>
				</select>
			</div>
			<div class="span3">
				<label>Exclude entities</label>
				<select name="excludeEntities" size="5" multiple>
					<cfloop array="#allEntityNames#" index="entity"><option #(listFindNoCase( url.excludeEntities, entity ))?"selected":""#>#entity#</option></cfloop>
				</select>
			</div>
			<div class="span2">
				<label class="checkbox">
					<input type="checkbox" name="isRelationshipsOnly" value="true" #(url.isRelationshipsOnly)?"checked":""#> Only show relationships
				</label>
			</div>
			<div class="span2">
				<label class="checkbox">
					<input type="checkbox" name="ormReload"> ORMReload
				</label>
				<button class="btn btn-success" name="View">View</button>
			</div>
		</div>
		
		</form>
		
		<cfif len( url.startEntity )>
			<div class="row-fluid">
				<div class="span12">
					<span class="label label-important">#url.startEntity#</span>
				</div>
			</div>
			#display( url.startEntity )#
		</cfif>
	
</cfoutput>

<cfinclude template="ui/footer.cfm">
