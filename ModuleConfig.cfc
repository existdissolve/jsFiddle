/**
Author 	 :	Joel Watson
Description :

This module allows you to add fiddles from jsFiddle.net

**/
component {

	// Module Properties
	this.title 				= "jsFiddle";
	this.author 			= "Joel Watson";
	this.webURL 			= "http://existdissolve.com";
	this.description 		= "Helps you embedd fiddles from jsFiddle";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "jsfiddle";

	function configure(){

		// Compressor Settings
		settings = {
			// Developer Key
			"width" = "100%",
			"height"= "300",
			"users"=''
		};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Custom Declared Interceptors
		interceptors = [
			{ class="#moduleMapping#.interceptors.jsFiddle", name="jsFiddle" }
		];

		// objects
		binder.map("jsFiddle@jsFiddle").to("#moduleMapping#.model.jsFiddle");
		binder.map("fileUtils@jsFiddle").to("coldbox.system.core.util.FileUtils");
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// Let's add ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		// Add Menu Contribution
		menuService.addSubMenu(topMenu=menuService.MODULES,name="jsFiddle",label="jsFiddle",href="#menuService.buildModuleLink('jsFiddle','home.settings')#");
		// Override settings?
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var args = {name="cbox-jsfiddle"};
		var setting = settingService.findWhere(criteria=args);
		if( !isNull(setting) ){
			// override settings from contentbox custom setting
			controller.getSetting("modules").jsFiddle.settings = deserializeJSON( setting.getvalue() );
		}
	}

	/**
	* Fired when the module is activated
	*/
	function onActivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		// store default settings
		var findArgs = {name="cbox-jsfiddle"};
		var setting = settingService.findWhere(criteria=findArgs);
		if( isNull(setting) ){
			var args = {name="cbox-jsfiddle", value=serializeJSON( settings )};
			var jsFiddleSettings = settingService.new(properties=args);
			settingService.save( jsFiddleSettings );
		}

		// Install the ckeditor plugin
		var ckeditorPluginsPath = controller.getSetting("modules")["contentbox-admin"].path & "/includes/ckeditor/plugins/cbjsFiddle";
		var fileUtils = controller.getWireBox().getInstance("fileUtils@jsFiddle");
		var pluginPath = controller.getSetting("modules")["jsFiddle"].path & "/includes/cbjsFiddle";
		fileUtils.directoryCopy(source=pluginPath, destination=ckeditorPluginsPath);
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		// Let's remove ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		// Remove Menu Contribution
		menuService.removeSubMenu(topMenu=menuService.MODULES,name="jsFiddle");
	}

	/**
	* Fired when the module is deactivated by ContentBox Only
	*/
	function onDeactivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var args = {name="cbox-jsfiddle"};
		var setting = settingService.findWhere(criteria=args);
		if( !isNull(setting) ){
			settingService.delete( setting );
		}
		// Uninstall the ckeditor plugin
		var ckeditorPluginsPath = controller.getSetting("modules")["contentbox-admin"].path & "/includes/ckeditor/plugins/cbjsFiddle";
		var fileUtils = controller.getWireBox().getInstance("fileUtils@jsFiddle");
		var pluginPath = controller.getSetting("modules")["jsFiddle"].path & "/includes/cbjsFiddle";
		fileUtils.directoryRemove(path=ckeditorPluginsPath, recurse=true);
	}
}