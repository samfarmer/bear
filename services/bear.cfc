component {

function getAllEntityNames() {
	var ormClassMetaData = ORMGetSessionFactory().getAllClassMetadata();
	var allEntities = [];
	
	for ( var ormClass in ormClassMetaData ) {
		arrayAppend( allEntities, ormClass );
	}
	
	arraySort( allEntities, "textnocase" );
	return allEntities;
}

function getFunctionData( required array entities ) {
	var data = [];
	var functionInfo = '';
	
	for ( var entity in entities ){
		var functionResults = { name=entity, customFunctionCount=0, eventFunctionCount=0, functionList='' };
		var meta = getMetadata( entityNew( entity ) );
		var allFunctionCount = arrayLen( meta.functions );
		
		for ( var i = 1; i <= allFunctionCount; i++ ) {
			functionInfo = meta.functions[ i ];
			if ( reFind( '[^A-Z0-9_]', functionInfo.name ) ) {
				if ( left( functionInfo.name, 3 ) == 'pre' || left( functionInfo.name, 4 ) == 'post' ) {
					functionResults.eventFunctionCount++;
				} else {
					functionResults.customFunctionCount++;
				}
				functionResults.functionList = listAppend( functionResults.functionList, functionInfo.name, ' ');		
			}
		}
		
		functionResults.functionList = listSort( functionResults.functionList, 'textnocase', 'Asc', ' ' );
		arrayAppend( data, functionResults );
	}
	
	return data;
}


}