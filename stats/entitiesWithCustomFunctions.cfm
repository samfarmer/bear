<cfscript>

data = bear.getFunctionData( bear.getAllEntityNames() );

	
</cfscript>

<cfinclude template="/ui/header.cfm">

<h1>bear stats</h1>

<div class="row">
	<div class="span12">

		<table class="table table-condensed">
			<thead>
				<tr>
					<th>Entity</th>
					<th>Custom</th>
					<th>Events</th>
					<th>Functions</th>
				</tr>
			</thead>
		<cfoutput>
			<cfloop array="#data#" index="row">
				<tr>
					<td valign="top">#row.name#</td>
					<td valign="top">#row.customFunctionCount#</td>
					<td valign="top">#row.eventFunctionCount#</td>
					<td>#row.functionList#</td>
				</tr>
			</cfloop>
		</cfoutput>
		
		</table>

	</div>
</div>
<cfinclude template="/ui/footer.cfm">
