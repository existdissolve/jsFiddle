<cfscript>
	event.paramValue( "url", "" );
	event.paramValue( "title", "" );
	event.paramValue( "height", prc.settings.height );
	event.paramValue( "width", prc.settings.width );
	event.paramValue( "css", false );
	event.paramValue( "js", false );
	event.paramValue( "html", false );
	event.paramValue( "resources", false );
	event.paramValue( "result", false );
</cfscript>
<cfoutput>
<h2>Edit jsFiddle</h2>
<div class="body" id="mainBody">
#html.startForm(name="jsFiddleForm")#
	<div>
	<!-- Content area that wil show the form and stuff -->
		<fieldset>
			<legend><img src="#prc.cbRoot#/includes/images/world.png" alt="modifiers"/> <strong>Fiddle Details</strong></legend>
            <div id="fiddlebyurl">
                #html.textField(name="url", label="Fiddle URL:", class="textfield width98", required="required", value="#event.getValue( 'url' )#")#
                #html.textField(name="title", label="Fiddle Title:", class="textfield width98", required="required", value="#event.getValue( 'title' )#")#
                #html.textField(name="height", label="Fiddle Height:", value="#event.getValue( 'height' )#", class="textfield width98", required="required")#
                #html.textField(name="width", label="Fiddle Width:", value="#event.getValue( 'width' )#", class="textfield width98", required="required")#
				<label>Tabs to Include</label>
                <input type="checkbox" name="tabs" value="result" <cfif event.getValue( "result" )>checked=true</cfif> /> Result
                <input type="checkbox" name="tabs" value="js" <cfif event.getValue( "js" )>checked=true</cfif> /> JS
                <input type="checkbox" name="tabs" value="resources" <cfif event.getValue( "resources" )>checked=true</cfif> /> Resources
                <input type="checkbox" name="tabs" value="css" <cfif event.getValue( "css" )>checked=true</cfif> /> CSS
                <input type="checkbox" name="tabs" value="html" <cfif event.getValue( "html" )>checked=true</cfif> /> HTML
            </div>
		</fieldset>
        <button class="button2" type="button" onclick="updateFiddle( this );return false;"> Update Fiddle </button>
	</div> <!--- end main_column --->
#html.endForm()#
</div>
</cfoutput>