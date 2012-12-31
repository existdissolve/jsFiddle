component{

	// DI
	property name="settingService" 	inject="settingService@cb";
	property name="cb" 				inject="cbHelper@cb";
	property name="jsFiddle" 		inject="jsFiddle@jsFiddle";

	function settings(event,rc,prc){
		// Exit handler
		prc.xehSave = cb.buildModuleLink("jsFiddle","home.saveSettings");
		prc.tabModules_jsFiddle = true;
		// settings
		prc.settings = getModuleSettings("jsFiddle").settings;
		// view
		event.setView("home/settings");
	}

	function saveSettings(event,rc,prc){
		// Get compressor settings
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

		// Messagebox
		getPlugin("MessageBox").info("Settings Saved & Updated!");
		// Relocate via CB Helper
		cb.setNextModuleEvent("jsFiddle","home.settings");
	}

	function getFiddles(event,rc,prc){
		event.paramValue("user","");
		return jsFiddle.getFiddles(user=rc.user);
	}

	function entry(event,rc,prc){
		// settings
		prc.settings = getModuleSettings("jsFiddle").settings;
		prc.xehEmbedCode = cb.buildModuleLink("jsFiddle","home.getFiddles");

		// view
		event.setView(view="home/entry")
			.setLayout(name="ajax", module="contentbox-admin");
	}

}