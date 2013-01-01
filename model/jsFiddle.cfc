component accessors="true"{

	// Compressor Settings
	property name="settings" inject="coldbox:moduleSettings:jsFiddle";
	property name="settingService" 	inject="settingService@cb";

	// Constructor
	function init(){
		return this;
	}

	/**
	* Get fiddles for a user from jsfiddle.net
	*/
	public any function getUserFiddles( required string user ){
		var jsFiddleURL = "http://jsfiddle.net/api/user/#arguments.user#/demo/list.json?limit=50";
		var jsFiddleService = new HTTP(url=jsFiddleURL, method="get", resolveURL=true, timeout="10");
		var results = jsFiddleService.send().getPrefix();
		return toString( results.filecontent );
	}
	
	/**
	 * Retrieves all saved fiddles for users from settings
	 * returns Array
	 */
	public array function getAllUserFiddles() {
		var fiddles = [];
		var c = settingService.newCriteria();
		// get all user fiddle settings
		var settingUsers = c.iLike( "name", "cbox-jsfiddle-%" ).list();
		// loop over the list
		for( var user in settingUsers ) {
			var fiddleCollection = deserializeJSON( user.getValue() ).fiddles;
			var name = replaceNoCase( user.getName(), "cbox-jsfiddle-", "", "all" );
			var userFiddles = {
				"user"= name,
				"fiddles"= fiddleCollection
			};
			arrayAppend( fiddles, userFiddles );
		}
		return fiddles;
	}
	
	/**
     * Saves array of users
     * @users {Array} - array of users to save
     * returns null
     */
	public void function saveUsers( required array users ) {
		var user = '';
		// over over saved users
		for( user in arguments.users ) {
			// get all settings for saved user
			var userFiddles = settingService.findWhere( criteria={ name="cbox-jsfiddle-#user#" } );
			// if user exists
			if( !isNull( userFiddles ) ) {
				// get array of fiddles
				var userValues = deserializeJSON( userFiddles.getValue() );
				// check if expire date is defined, that it's a date, and that it's past the expiry date; if so, re-get user fiddles
				if( structKeyExists( uservalues, "expires" ) && isDate( uservalues.expires ) && datediff( 'd', uservalues.expires, now() ) > settings.cachetime ) {
					// get fiddles from jsfiddle.net
					var fiddles = getUserFiddles( user ).toString();
					var value = serializeJSON({
						"fiddles"=fiddles,
						"expires"=dateFormat( now(), 'yyyy-mm-dd' )
					});
					// if we have a valid response from jsfiddle.net, save the user setting
					if( isJSON( fiddles ) ) {
						userFiddles.setValue( value );
						settingService.save( userFiddles );
					}
				}
			}
			// if user setting doesn't exist, create a new one
			else {
				// get fiddles from jsfiddle.net
				var fiddles = getUserFiddles( user ).toString();
				// if we have a valid reponse, save the user setting
				if( isJSON( fiddles ) ) {
					var jsonArgs = {
						"fiddles"=fiddles,
						"expires"=dateFormat( now(), 'yyyy-mm-dd' )
					};
					var args = {name="cbox-jsfiddle-#user#", value=serializeJSON( jsonArgs ) };
					userFiddles = settingService.new( properties=args );
					settingService.save( userFiddles );
				}
			}
		}
	}
	
	public void function updateUserFiddles( required array users, required boolean forceUpdate=false ) {
		var user = '';
		// over over saved users
		for( user in arguments.users ) {
			// get all settings for saved user
			var userFiddles = settingService.findWhere( criteria={ name="cbox-jsfiddle-#user#" } );
			// if user exists
			if( !isNull( userFiddles ) ) {
				// get array of fiddles
				var userValues = deserializeJSON( userFiddles.getValue() );
				// check if expire date is defined, that it's a date, and that it's past the expiry date; if so, re-get user fiddles
				if( ( structKeyExists( uservalues, "expires" ) && isDate( uservalues.expires ) && datediff( 'd', uservalues.expires, now() ) > settings.cachetime ) || arguments.forceUpdate ) {
					// get fiddles from jsfiddle.net
					var fiddles = getUserFiddles( user ).toString();
					var value = serializeJSON({
						"fiddles"=fiddles,
						"expires"=dateFormat( now(), 'yyyy-mm-dd' )
					});
					// if we have a valid response from jsfiddle.net, save the user setting
					if( isJSON( fiddles ) ) {
						userFiddles.setValue( value );
						settingService.save( userFiddles );
					}
				}
			}
		}
	}
	
	/**
     * Deletes settings for users that have been deleted from main jsfiddle setting
     * @users {Array} - array of users to cleanup
     * returns null
     */
	public void function cleanupUsers( required array users ) {
		var c = settingService.newCriteria();
		// get all user fiddle settings
		var settingUsers = c.iLike( "name", "cbox-jsfiddle-%" ).list();
		// loop over the list
		for( var user in settingUsers ) {
			var username = replaceNoCase( user.getName(), "cbox-jsfiddle-", "", "all" );
			// if username in setting doesn't exist in our list of saved users, delete it
			if( !arrayContains( arguments.users, username ) ) {
				settingService.delete( user );
			}
		}
	}
}