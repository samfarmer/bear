<cfif fileExists( request.dgmrRunningDirectory & "settings.cfm" )>
	<cffile action="delete" file="#request.dgmrRunningDirectory#settings.cfm">
</cfif>

<cfinclude template="ui/header.cfm">

<div class="hero-unit">
	<h1>Hi! Lets set up bear.</h1>
	<br><br>
	<p>The following settings are stored in settings.cfm. That way they stay out of the repository code and allow you to configure bear to run on the entities you want.</p>
	<br><br>
	<ul>
		<li>The root mapping should point to the directory your entities are in.</li>
		<li>Datasource, is, well the datasource.</li>
		<li>What you enter below will be saved directly into settings.cfm so write nice, valid, cfscript style ColdFusion.</li>
	</ul>
	<form method="post">
	
	<textarea name="allsettings" rows="5" class="span6">
this.mappings["/"] = "";
this.datasource = "";
	</textarea>
	<br>
	<button class="btn btn-success" name="makeSettings">Make Settings File</button>
	</form>
</div>

<cfinclude template="ui/footer.cfm">
