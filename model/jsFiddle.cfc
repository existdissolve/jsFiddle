component accessors="true"{

	// Compressor Settings
	property name="settings" inject="coldbox:moduleSettings:jsFiddle";

	// Constructor
	function init(){
		return this;
	}

	/**
	* Sends a pastebin request
	*/
	function getFiddles( required string user ){
		var jsFiddleURL = "http://jsfiddle.net/api/user/#arguments.user#/demo/list.json?limit=50";
		var jsFiddleService = new HTTP(url=jsFiddleURL, method="get", resolveURL=true, timeout="10");
		var results = jsFiddleService.send().getPrefix();
		return results.filecontent;
	}

}