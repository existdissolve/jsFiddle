<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">

	<!--- Info Box --->
	<div class="small_box expose">
		<div class="header">
			About This Module
		</div>
		<div class="body">
			<p>
			    This module is a just a simple, but handy way to insert "fiddles" from the excellent <a href="http://jsfiddle.net">jsfiddle.net</a>.
			</p>
            <p>
                With this module, you can set defaults for the size of iFrames that are embedded, as well as which "resource" tabs to include on each fiddle.
            </p>
            <p>
                Finally, if you have a number of jsfiddle.net accounts that you'd like to track, simply add them here, and then you'll be able to select from those users' fiddles when inserting a fiddle into a page or entry.
            </p>
            <p>Enjoy!</p>
		</div>
	</div>

</div>
<!--End sidebar-->
<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<!--- Body Header --->
		<div class="header">
			jsFiddle Settings
		</div>
		<!--- Body --->
		<div class="body" id="mainBody">
			#getPlugin("MessageBox").renderit()#

			<p>
				Below you can modify the settings used by the jsFiddle module. 
			</p>
			<p>
				In your editors you will get a new icon for inserting fiddles from your configured accounts (<img src="#event.getModuleRoot('jsFiddle')#/includes/cbjsFiddle/jsFiddle.png" alt="icon" />).
				You'll need a connection to the internet to use this module since it needs to make API calls to <em>http://jsfiddle.net</em>.
			</p>

			#html.startForm(action="cbadmin.module.jsFiddle.home.saveSettings",name="settingsForm",id="settingsForm",class="form-vertical")#

				<fieldset>
				<legend><strong>Options</strong></legend>
					#html.textField(name="width", label="Default Fiddle Width:", value="#prc.settings.width#",class="textfield",wrapper="div class=controls",labelClass="control-label",groupWrapper="div class=control-group", required="required", default="100%")#
					#html.textField(name="height", label="Default Fiddle Height:", value="#prc.settings.height#",class="textfield",wrapper="div class=controls",labelClass="control-label",groupWrapper="div class=control-group", default="300")#
					#html.textField(name="cachetime", label="Cache Time (Days):", value="#prc.settings.cachetime#",class="textfield",wrapper="div class=controls",labelClass="control-label",groupWrapper="div class=control-group", default="5")#
					<label>Tabs to Include</label>
                    <input type="checkbox" name="tabs" value="result" <cfif listContains( prc.settings.tabs, "result" )>checked=true</cfif> /> Result
                    <input type="checkbox" name="tabs" value="js" <cfif listContains( prc.settings.tabs, "js" )>checked=true</cfif> /> JS
                    <input type="checkbox" name="tabs" value="resources" <cfif listContains( prc.settings.tabs, "resources" )>checked=true</cfif> /> Resources
                    <input type="checkbox" name="tabs" value="css" <cfif listContains( prc.settings.tabs, "css" )>checked=true</cfif> /> CSS
                    <input type="checkbox" name="tabs" value="html" <cfif listContains( prc.settings.tabs, "html" )>checked=true</cfif> /> HTML                    
					#html.hiddenField(name="users", value="#prc.settings.users#")#
					<div class="control-group">
						<div class="controls">
							<label class="control-label">jsFiddle Users:</label>
	                   		<input type="text" class="textfield" name="jsfiddleuser" value="" />
	                   		<div id="add-holder" style="display:inline;">
                    			<img src="#event.getModuleRoot('jsFiddle')#/includes/add.png" class="add_jsfiddleuser" />
                    		</div>
	                   	</div>
	                </div>
                    <ul class="jsfiddleusers">
                    <cfif listLen( prc.settings.users )>
						<cfloop list="#prc.settings.users#" index="user">
							<li class="jsfiddleuser"><img height="16" src="#event.getModuleRoot('jsFiddle')#/includes/delete.png" class="delete_jsfiddleuser" /><span>#user#</span></li>
						</cfloop>
					</cfif>
					</ul>
				</fieldset>

				<!--- Submit --->
				<div class="form-actions">
					<cfif listLen( prc.settings.users )>
                   		#html.button(value="Update Cached Fiddles",class="btn",id="updatefiddles",title="Update cached fiddles for all users")#
					</cfif>
					#html.submitButton(value="Save Settings",class="btn btn-danger",title="Save the jsFiddle settings")#
				</div>

			#html.endForm()#

		</div>
	</div>
</div>
</cfoutput>