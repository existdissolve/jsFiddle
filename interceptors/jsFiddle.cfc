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
		var regex 	= "<fiddle\b[^>]*>(.*?)</fiddle>";
		// get string builder
		var builder = arguments.interceptData.builder;
		// find regex matches 
		var targets = reMatch( regex, builder.toString() );
		var replacer = "";
		// loop over all matches
		for( var match in targets ) {
			// get attributes
			var attributes = reMatch( '[a-z]+=\"[a-zA-Z0-9\.\?\&/:%]+\"', match );
			var urlArgs = "";
			replacer = "";
			replacer &= "<iframe ";
			// loop over attributes and deal with them as needed
			for( var attribute in attributes ) {
				switch( listGetAt( attribute, 1, "=" ) ) {
					case "css":
					case "js":
					case "html":
					case "resources":
					case "result":
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
							theurl &= urlArgs;
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
}