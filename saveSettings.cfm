<cfset fileContent = "<cfscript>
#form.allsettings#
</cfscript>">
<cffile action="write" file="#request.dgmrRunningDirectory#settings.cfm" output="#fileContent#">
