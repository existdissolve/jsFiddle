<cfoutput>
<h2>Insert jsFiddle</h2>
<div>
	<p>Do something with fiddles...</p>
    <div class="main_column">
    <div class="body" id="mainBody">
	#html.startForm(name="pasteBinForm")#

		<div class="body_vertical_nav clearfix">
			<!--- Navigation Bar --->
			<ul class="vertical_nav">
				<li class="active"><a href="##byuser"><img src="#prc.cbRoot#/includes/images/settings_black.png" alt="By User"/> User Fiddles</a></li>
				<li><a href="##adhoc"><img src="#prc.cbRoot#/includes/images/database_black.png" alt="Ad-hoc"/> Fiddle By URL</a></li>
			</ul>
			<div class="main_column">
				<!-- Content area that wil show the form and stuff -->
				<div class="panes_vertical">
				    <cfif listLen( prc.settings.users )>
					<!--- Fiddles By User --->
					<div>
        				<fieldset>
        					<legend><img src="#prc.cbRoot#/includes/images/settings_black.png" alt="modifiers"/> <strong>User Fiddles</strong></legend>
        					<p>Choose a user below</p>
        					<select name="user" id="userselect">
        					    <option value="">Select a User</option>
                                <cfloop list="#prc.settings.users#" index="user">
									<option value="#user#">#user#</option>
								</cfloop>
        					</select>
        				</fieldset>
                        <fieldset id="userfiddles">
        					<legend><img src="#prc.cbRoot#/includes/images/settings_black.png" alt="modifiers"/> <strong>Fiddles</strong></legend>
        					<div id="userfiddle-list"></div>
        				</fieldset>
					</div>
					</cfif>
					<!--- Manual URL entry for fiddle --->
					<div>
						<fieldset>
							<legend><img src="#prc.cbRoot#/includes/images/database_black.png" alt="modifiers"/> <strong>Fiddle By URL</strong></legend>
							<p>From here you can control the HTML Compression Caching Settings.</p>
						</fieldset>
					</div>
				</div> <!--- end vertical panes --->
			</div> <!--- end main_column --->

		</div> <!--- End vertical nav --->

	#html.endForm()#
	</div>
    </div>
</div>
<hr/>
<!--- Button Bar --->
<div id="bottomCenteredBar" class="textRight">
	<button class="button2" onclick="embedPasteBin()"> Embed Code </button>
	<button class="buttonred" onclick="closeRemoteModal()"> Cancel </button>
</div>
</cfoutput>