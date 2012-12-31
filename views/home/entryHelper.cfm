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
</style>
<!--- Custom Javascript --->
<script type="text/javascript" src="#event.getModuleRoot('contentbox-admin')#/includes/js/contentbox.js"></script>
<script type="text/javascript">
    $( '##userselect' ).change( function() {
        getUserFiddles( this.value );
    })
    
    $( '.config-fiddle' ).live( 'click', function() {
        $( this ).parent().next().slideToggle( 'fast' );
    })
    
    function getUserFiddles( user ) {
        $.ajax({
            type: 'get',
            url: '#prc.xehEmbedCode#?user=' + user,
            async: false,
            success: function( data ) {
                var fiddles = jQuery.parseJSON( data );
                createFiddles( fiddles );
            }
        });
    }
    
    function createFiddles( fiddles ) {
        var fiddleContainer = $( '##userfiddles' )[0],
            fiddleHome = $( '##userfiddle-list' ),
            fiddleHTML = [];
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
                                    '<input type="text" name="fiddle_height_' + i + '" value="#prc.settings.height#" />',
                                '</td>',
                                '<td>',
                                    '<label>Width</label>',
                                    '<input type="text" name="fiddle_width_' + i + '" value="#prc.settings.width#" />',
                                '</td>',
                            '</tr>',
                            '<tr>',
                                '<td colspan="2">',
                                    '<label>Tabs to Include</label>',
                                    '<input type="checkbox" name="fiddle_resource_' + i + '" value="js" /> JS',
                                    '<input type="checkbox" name="fiddle_resource_' + i + '" value="resources" class="spaced" /> Resources',
                                    '<input type="checkbox" name="fiddle_resource_' + i + '" value="css" class="spaced" /> CSS',
                                    '<input type="checkbox" name="fiddle_resource_' + i + '" value="html" class="spaced" /> HTML',
                                    '<input type="checkbox" name="fiddle_resource_' + i + '" value="result" class="spaced" /> Result',
                                '</td>',
                            '</tr>',
                        '</table>',
                    '</div>',
                '</div>'
            ];
            fiddleHome.append( content.join( '' ) )
        }
        //fiddleHome.append( fiddleHTML );
    }
    
    function sendEditorText(text){
    	$("###rc.editorName#").ckeditorGet().insertHtml( text );
    	closeRemoteModal();
    }
</script>
</cfoutput>