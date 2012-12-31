component extends="coldbox.system.Interceptor"{

	/**
	* CKEditor Integrations
	*/
	function cbadmin_ckeditorExtraPlugins( event, interceptData ){
		arrayAppend( arguments.interceptData.extraPlugins, "cbjsFiddle" );
	}

	/**
	* CKEditor Integrations
	*/
	function cbadmin_ckeditorToolbar( event, interceptData ){
		var itemLen = arrayLen( arguments.interceptData.toolbar );
		for( var x =1; x lte itemLen; x++ ){
			if( isStruct( arguments.interceptData.toolbar[x] )
			    AND arguments.interceptData.toolbar[x].name eq "contentbox" ){
				arrayAppend( arguments.interceptData.toolbar[x].items, "cbjsFiddle" );
				break;
			}
		}
	}
}