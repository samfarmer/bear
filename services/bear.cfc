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

function getFunctionData( required array entities ) hint="I return stats on how many custom functions an entity has. This is determined by counting functions that have a lowercase letter in them as implicit CF generated functions are all uppercase." {
	var data = [];
	var functionInfo = '';
	
	for ( var entity in entities ){
		var functionResults = { name=entity, customFunctionCount=0, eventFunctionCount=0, functionList='' };
		var meta = getMetadata( entityNew( entity ) );
		var allFunctionCount = arrayLen( meta.functions );
		
		for ( var i = 1; i <= allFunctionCount; i++ ) {
			functionInfo = meta.functions[ i ];
			if ( reFind( '[a-z]', functionInfo.name ) ) {
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