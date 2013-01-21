component extends="coldbox.system.Interceptor"{

	/**
	* CKEditor Integrations
	*/
	function cbadmin_ckeditorExtraPlugins( required any event, required struct interceptData ){
		arrayAppend( arguments.interceptData.extraPlugins, "cbjsFiddle" );
	}

	/**
	* CKEditor Integrations
	*/
	function cbadmin_ckeditorToolbar( required any event, required struct interceptData ){
		var itemLen = arrayLen( arguments.interceptData.toolbar );
		for( var x =1; x lte itemLen; x++ ){
			if( isStruct( arguments.interceptData.toolbar[x] )
			    AND arguments.interceptData.toolbar[x].name eq "contentbox" ){
				arrayAppend( arguments.interceptData.toolbar[x].items, "cbjsFiddle" );
				break;
			}
		}
	}
	
	/**
     * Intercepts on cb_onContentRendering to replace custom tag syntax
     */
	function cb_onContentRendering( required any event, required struct interceptData ) {
		// regex for fiddle tag syntax
		var regex 	= "<(div)\b([^>]*?)(cbjsfiddle)([^>]*?)>(.*?)</div>";
		// get string builder
		var builder = arguments.interceptData.builder;
		// find regex matches 
		var targets = reMatch( regex, builder.toString() );
		var replacer = "";
		// loop over all matches
		for( var match in targets ) {
			// get attributes
			var attributes = reMatch( '[a-z]+=\"[a-zA-Z0-9\.\?\&/:%]+\"', match );
			var urlStatic = "result,js,css,html,resources";
			var urlArgs = "";
			replacer = "";
			replacer &= "<iframe ";
			// loop over attributes and deal with them as needed
			for( var attribute in attributes ) {
				switch( listGetAt( attribute, 1, "=" ) ) {
					case "result":
					case "js":
					case "css":
					case "html":
					case "resources":
					
						if( listGetAt( attribute, 2, "=" )=='"true"' ) {
							urlArgs = listAppend( urlArgs, listGetAt( attribute, 1, "=" ) );
						}
						break;
					case "height":
					case "width":
						replacer &= " #listGetAt( attribute, 1, '=' )#=#listGetAt( attribute, 2, '=' )#";	
						break;
					case "src":
						var theurl = replace( listGetAt( attribute, 2, "=" ), '"', '', 'all' );
							theurl &= right( theurl, 1 )=="/" ? "embedded/" : "/embedded/";
							theurl &= ListInCommon( urlArgs, urlStatic );
						replacer &= " #listGetAt( attribute, 1, '=' )#=""#theurl#""";
						break;
				}
			}
			replacer &= "></iframe>";
			// find the match syntax position
			var pos = builder.indexOf( match );
			// get the length
			var len = len( match );
			while( pos gt -1 ){
				// Replace it
				builder.replace( javaCast( "int", pos ), JavaCast( "int", pos+len ), replacer );
				// look again
				pos = builder.indexOf( match, javaCast( "int", pos ) );
			}			
		}
	}
	
	function ListInCommon(List1, List2) {
        var TempList = "";
        var Delim1 = ",";
        var Delim2 = ",";
        var Delim3 = ",";
        var i = 0;
        // Handle optional arguments
        switch(ArrayLen(arguments)) {
            case 3:
	            Delim1 = Arguments[3];
            	break;
            case 4:
            	Delim1 = Arguments[3];
            	Delim2 = Arguments[4];
           		break;
            case 5:
            	Delim1 = Arguments[3];
            	Delim2 = Arguments[4];          
            	Delim3 = Arguments[5];
            	break;      
        } 
        /* Loop through the second list, checking for the values from the first list.
        * Add any elements from the second list that are found in the first list to the
        * temporary list
        */  
        for (i=1; i LTE ListLen(List2, "#Delim2#"); i=i+1) {
       		if (ListFindNoCase(List1, ListGetAt(List2, i, "#Delim2#"), "#Delim1#")){
        		TempList = ListAppend(TempList, ListGetAt(List2, i, "#Delim2#"), "#Delim3#");
        	}
        }
        Return TempList;
	}
}