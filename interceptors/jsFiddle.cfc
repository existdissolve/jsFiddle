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
     * Intercepts on cb_onContentRendering to replace custom double-musta
     */
	function cb_onContentRendering( required any event, required struct interceptData ) {
		// regex for fiddle mustache syntax
		var regex 	= "\{\{fiddle[^\}]*\}\}";
		// get string builder
		var builder = arguments.interceptData.builder;
		// find regex matches 
		var targets = reMatch( regex, builder.toString() );
		var replacer = "";
		// loop over all matches
		for( var match in targets ) {
			// replace mustache syntax with tags
			replacer = replace( match, "{{fiddle", "<iframe " );
			replacer = replace( replacer,"}}","></iframe>", "one" );
			replacer = replace( replacer,"&##34;",'"',"all" );
			replacer = replace( replacer,"&##39;","'","all" );
			replacer = replace( replacer,"&quot;","'","all" );
			// find the mustache syntax position
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