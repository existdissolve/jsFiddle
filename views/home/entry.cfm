<cfoutput>
<h2>Insert jsFiddle</h2>
<div>
	
    <div class="main_column">
    <div class="body" id="mainBody">
	#html.startForm(name="jsFiddleForm")#

		<div class="body_vertical_nav clearfix">
			<!--- Navigation Bar --->
			<ul class="vertical_nav">
				<li class="active"><a href="##byuser"><img src="#prc.cbRoot#/includes/images/users_icon.png" height="16" alt="By User"/> User Fiddles</a></li>
				<li><a href="##adhoc"><img src="#prc.cbRoot#/includes/images/world.png" alt="Ad-hoc"/> Fiddle By URL</a></li>
			</ul>
			<div class="main_column">
				<!-- Content area that wil show the form and stuff -->
				<div class="panes_vertical">
				    <cfif arrayLen( prc.settings.fiddles )>
					<!--- Fiddles By User --->
					<div>
        				<fieldset>
        					<legend><img src="#prc.cbRoot#/includes/images/users_icon.png" height="16" alt="modifiers"/> <strong>User Fiddles</strong></legend>
        					<p>Choose a user below</p>
        					<select name="user" id="userselect">
        					    <option value="">Select a User</option>
                                <cfloop array="#prc.settings.fiddles#" index="user">
									<option value="#user.user#">#user.user#</option>
								</cfloop>
        					</select>
        				</fieldset>
                        <fieldset id="userfiddles">
        					<legend><img src="#event.getModuleRoot('jsFiddle')#/includes/cbjsFiddle/jsfiddle.png" alt="modifiers"/> <strong>Fiddles</strong></legend>
        					<div id="userfiddle-list"></div>
        				</fieldset>
					</div>
					</cfif>
					<!--- Manual URL entry for fiddle --->
					<div>
						<fieldset>
							<legend><img src="#prc.cbRoot#/includes/images/world.png" alt="modifiers"/> <strong>Fiddle By URL</strong></legend>
							<p>Fiddle doesn't belong to one of your configured users? No problem, just enter the URL for the fiddle below!</p>
                            <div id="fiddlebyurl">
                                #html.textField(name="url", label="Fiddle URL:", class="textfield width98", required="required")#
                                #html.textField(name="height", label="Fiddle Height:", value="#prc.settings.height#", class="textfield width98", required="required")#
                                #html.textField(name="width", label="Fiddle Width:", value="#prc.settings.width#", class="textfield width98", required="required")#
            					<label>Tabs to Include</label>
                                <input type="checkbox" name="tabs" value="js" <cfif listContains( prc.settings.tabs, "js" )>checked=true</cfif> /> JS
                                <input type="checkbox" name="tabs" value="resources" <cfif listContains( prc.settings.tabs, "resources" )>checked=true</cfif> /> Resources
                                <input type="checkbox" name="tabs" value="css" <cfif listContains( prc.settings.tabs, "css" )>checked=true</cfif> /> CSS
                                <input type="checkbox" name="tabs" value="html" <cfif listContains( prc.settings.tabs, "html" )>checked=true</cfif> /> HTML
                                <input type="checkbox" name="tabs" value="result" <cfif listContains( prc.settings.tabs, "result" )>checked=true</cfif> /> Result
                            </div>
						</fieldset>
                        <button class="button2" onclick="insertFiddleByURL( this );return false;"> Insert Fiddle </button>
					</div>
				</div> <!--- end vertical panes --->
			</div> <!--- end main_column --->

		</div> <!--- End vertical nav --->

	#html.endForm()#
	</div>
    </div>
</div>
</cfoutput>