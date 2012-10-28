component {

this.name = "bear";
request.dgmrRunningDirectory = getDirectoryFromPath( getCurrentTemplatePath() );

//The following code and its placement is a little odd. Its here to give developers the ability to download then run code to do the setup.
if ( fileExists( request.dgmrRunningDirectory & "settings.cfm" ) ) {
	include "settings.cfm";
} else if ( structKeyExists( form, "makeSettings" ) ) {
	include "saveSettings.cfm";
	location( url="index.cfm?ormReload", addtoken=false );
} else {
	include "setup.cfm";
	abort;
}

this.ormEnabled = true;
this.ormSettings.useDBForMapping = false;


function onRequestStart() {
	if ( structKeyExists( url, "ormReload" ) ) {
		ormReload();
	}
}

function onError( Exception, EventName ) {
	writeOutput("<h2>bear error</h2>");
	writeDump(arguments);
}

}