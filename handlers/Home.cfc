component{

	// DI
	property name="settingService" 	inject="settingService@cb";
	property name="cb" 				inject="cbHelper@cb";
	property name="jsFiddle" 		inject="jsFiddle@jsFiddle";

	function settings( required Any event, required Struct rc, required Struct prc ){
		// Exit handler
		prc.xehSave = cb.buildModuleLink("jsFiddle","home.saveSettings");
		prc.xehCheckLink = cb.buildModuleLink("jsFiddle","home.checkUserIsReal");
		prc.xehForceUpdateUserFiddles = cb.buildModuleLink("jsFiddle","home.forceUpdateUserFiddles");
		prc.tabModules_jsFiddle = true;
		// settings
		prc.settings = getModuleSettings("jsFiddle").settings;
		// view
		event.setView("home/settings");
	}

	function saveSettings( required Any event, required Struct rc, required Struct prc ){
		// Get jsfiddle settings
		prc.settings = getModuleSettings("jsFiddle").settings;

		// iterate over settings
		for(var key in prc.settings){
			// save only sent in setting keys
			if( structKeyExists(rc, key) ){
				prc.settings[ key ] = rc[ key ];
			}
		}

		// Save settings
		var args = {name="cbox-jsfiddle"};
		var setting = settingService.findWhere(criteria=args);
		setting.setValue( serializeJSON( prc.settings ) );
		settingService.save( setting );
		jsFiddle.saveUsers( users=listToArray( prc.settings.users ) );
		jsFiddle.cleanupUsers( listToArray( prc.settings.users ) );
		// Messagebox
		getPlugin("MessageBox").info("Settings Saved & Updated!");
		// Relocate via CB Helper
		cb.setNextModuleEvent("jsFiddle","home.settings");
	}

	function forceUpdateUserFiddles( required Any event, required Struct rc, required Struct prc ) {
		// Get jsfiddle settings
		prc.settings = getModuleSettings( "jsFiddle" ).settings;
		jsFiddle.updateUserFiddles( users=listToArray( prc.settings.users ), forceUpdate=true );
        return 'yes';
	}

	function getFiddles( required Any event, required Struct rc, required Struct prc ){
		event.paramValue("user","");
		return jsFiddle.getFiddles(user=rc.user);
	}
	
	function checkUserIsReal(  required Any event, required Struct rc, required Struct prc  ) {
		event.paramValue("user","");
		var fiddles = jsFiddle.getUserFiddles( user=rc.user );
		var mydata = isJSON( fiddles ) ? "yes" : "no";
		if( event.isAjax() ) {
			return mydata;
		}
	}
	
	function entry( required Any event, required Struct rc, required Struct prc ){
		// settings
		prc.settings = getModuleSettings("jsFiddle").settings;
		prc.settings.fiddles = jsFiddle.getAllUserFiddles();
		prc.xehEmbedCode = cb.buildModuleLink("jsFiddle","home.getFiddles");

		// view
		event.setView(view="home/entry")
			.setLayout(name="ajax", module="contentbox-admin");
	}

	function edit( required Any event, required Struct rc, required Struct prc ){
		// settings
		prc.settings = getModuleSettings("jsFiddle").settings;
		prc.xehEmbedCode = cb.buildModuleLink("jsFiddle","home.getFiddles");
		// view
		event.setView(view="home/edit")
			.setLayout(name="ajax", module="contentbox-admin");
	}
}