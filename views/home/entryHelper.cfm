<cfoutput>
<style type="text/css">
    .fiddle {border: solid 2px ##DADADA;border-radius: 4px;background: white;padding: 5px 10px 0 10px;margin-bottom: 10px;}
    .fiddle-header {font-weight:bold;font-size:120%;}
    .fiddle-header img {margin-top:-2px;margin-right:5px;}
    .fiddle-description {line-height: 1.4em;font-size: 90%;color: ##999;}
    .fiddle-action {background: ##EAEAEA;margin: 5px -10px 0;padding: 0 10px;border-top: solid 1px ##DADADA;}
    .fiddle-action a {}
    .fiddle-action a.view-fiddle {margin-left:20px;}
    .fiddle-config {display:none;}
    .spaced {margin-left:20px !important;}
    .fiddle-config input[type=text] { width: 190px;}
    .insertfiddle {border-top: solid 1px ##DADADA;margin: 0 -10px;padding: 0 10px;font-weight: bold;}
    .insertfiddle img {margin-right:5px;margin-top:-2px;}
    ##userfiddles {display:none;}
</style>
<!--- Custom Javascript --->
<script type="text/javascript">
    // define a format method so we can easily do 'my {0} is {1}'.format( 'content', 'awesome' );
    String.prototype.format = function() {
        var s = this,
            i = arguments.length;
    
        while (i--) {
            s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
        }
        return s;
    };
    // set global variables for the JSON result from all user fiddles; cheaper than reloading remotely with every request
    var FIDDLES = #serializeJSON( prc.settings.fiddles )#;
    // setup listener for vertical nav
    //$("ul.vertical_nav").tabs("div.panes_vertical> div", {effect: 'fade'});
    // setup listener for user selector
    $( '##userselect' ).change( function() {
        $( '##userfiddles' ).show( 100 );
        getUserFiddles( this.value );
    });
    
    /*
     * Insert a fiddle manually by providing the URL
     */
    function insertFiddleByURL( btn ) {
        var inputs = $( btn ).parent().prev().find( 'input' );
        prepareFiddle( inputs );
    } 
    
    /*
     * Common method to prepare fiddles for insertion...and insert them
     * @inputs - collection of inputs
     */
    function prepareFiddle( inputs ) {
        var vals = [],
            html = '';
        inputs.each(function() {
             if( this.type=='checkbox' ) {
                vals.push( this.checked ? true : false );
            }
            else {
                // add values to array
                vals.push( this.value );  
            }
        })
        if( vals[0]=='' ) {
            alert( 'Please enter a URL!' );
            return false;
        }
        // create double-mustache syntax
        html += '<div id="cbjsfiddle" height="{2}" width="{3}" src="{0}" result="{4}" js="{5}" resources="{6}" css="{7}" html="{8}" >jsFiddle - {1}</div>'.format( vals[0], vals[1], vals[2], vals[3], vals[4], vals[5], vals[6], vals[7], vals[8] );
        // insert into editor
        sendEditorText ( html );
    }
    
    /*
     * Simple matching method for user fiddles in global object
     * @user {String} the user for which to search
     */
    function findUserFiddles( user ) {
        for( var i in FIDDLES ) {
            if( FIDDLES[ i ].user==user ) {
                return FIDDLES[ i ].fiddles; 
            }
        }
    }
    
    /*
     * Main handler method for generting HTML from fiddle data
     * @user {String} the user for which fiddle content is being created
     */
    function getUserFiddles( user ) {
        var userfiddles = findUserFiddles( user );
        createFiddles( jQuery.parseJSON( userfiddles ) );
    }
    
    /*
     * Basic HTML builder for fiddles
     * @fiddles {Array} an array of user fiddles for which HTML should be created
     */
    function createFiddles( fiddles ) {
        var fiddleContainer = $( '##userfiddles' )[0],
            fiddleHome = $( '##userfiddle-list' ),
            fiddleHTML = [];
        // clear list
        fiddleHome.empty();
        for( var i in fiddles ) {
            var fiddle = fiddles[ i ],
                content = '';
            content = [
                '<div class="fiddle">',
                    '<div class="fiddle-header"><img src="#event.getModuleRoot('jsFiddle')#/includes/cbjsFiddle/jsfiddle.png" height="16" />',
                        fiddle.title,
                    '</div>',
                    '<div class="fiddle-description">',
                        fiddle.description,
                    '</div>',
                    '<div class="fiddle-action">',
                        '<a href="javascript:void(0);" class="config-fiddle" id="fiddle_' +i+ '">Configure</a>',
                        '<a href="' +fiddle.url+ '" target="_blank" class="view-fiddle">View</a>',
                    '</div>',
                    '<div class="fiddle-config">',
                        '<table border="0" cellpadding="0" cellspacing="0" width="100%">',
                            '<tr>',
                                '<td>',
                                    '<label>Height</label>',
                                    '<input type="hidden" name="fiddle_url" value="' + fiddle.url + '" />',
                                    '<input type="hidden" name="fiddle_title" value="' + fiddle.title + '" />',
                                    '<input type="text" name="fiddle_height" value="#prc.settings.height#" />',
                                '</td>',
                                '<td>',
                                    '<label>Width</label>',
                                    '<input type="text" name="fiddle_width" value="#prc.settings.width#" />',                             
                                '</td>',
                            '</tr>',
                            '<tr>',
                                '<td colspan="2">',
                                    '<label>Tabs to Include</label>',
                                    '<input type="checkbox" name="fiddle_tabs" value="result" <cfif listContains( prc.settings.tabs, "result" )>checked=true</cfif> /> Result',
                                    '<input type="checkbox" name="fiddle_tabs" value="js" class="spaced" <cfif listContains( prc.settings.tabs, "js" )>checked=true</cfif> /> JS',
                                    '<input type="checkbox" name="fiddle_tabs" value="resources" class="spaced" <cfif listContains( prc.settings.tabs, "resources" )>checked=true</cfif> /> Resources',
                                    '<input type="checkbox" name="fiddle_tabs" value="css" class="spaced" <cfif listContains( prc.settings.tabs, "css" )>checked=true</cfif> /> CSS',
                                    '<input type="checkbox" name="fiddle_tabs" value="html" class="spaced" <cfif listContains( prc.settings.tabs, "html" )>checked=true</cfif> /> HTML',
                                    
                                '</td>',
                            '</tr>',
                        '</table>',
                        '<div class="insertfiddle">',
                            '<a href="javascript:void(0);" class="insert-fiddle"><img src="#event.getModuleRoot('jsFiddle')#/includes/add.png" height="12" />Insert Fiddle</a>',
                        '</div>',
                    '</div>',
                '</div>'
            ];
            fiddleHome.append( content.join( '' ) )
        }
        // setup listener for config toggles
        $( '.config-fiddle' ).click( function() {
            $( this ).parent().next().slideToggle( 300 );
        })
        // setup listner for insert action
        $( '.insert-fiddle' ).click( function() {
            // get all inputs
            var inputs = $( this ).parent().parent().find( 'input' );
            prepareFiddle( inputs );
        });
    }
    
    /**
     * Main method for creating a new element in the CKEditor area
     * @param {String} content Content to use to use to create the element
     */
    function sendEditorText( content ){
    	$("###rc.editorName#").ckeditorGet().insertElement( CKEDITOR.dom.element.createFromHtml( content ) );
    	closeRemoteModal();
    }
</script>
</cfoutput>
