// hack for old IE versions
var fallbackSelection;
CKEDITOR.plugins.add('cbjsFiddle',{
    lang : "en",
    icons: "jsfiddle",
	init:function( editor ){
        var pluginCmd='cbjsFiddleDialog';
        // add a custom stylesheet to the editor so we can style the <fiddle> tag
        if( typeof CKEDITOR.config.contentsCss=='object' ) {
            CKEDITOR.config.contentsCss.push( this.path + 'css/editor.css' );
        }  
        else {
            CKEDITOR.config.contentsCss = [CKEDITOR.config.contentsCss, this.path + 'css/editor.css'];
        }           
        // add insert command
		editor.addCommand( 'cbjsFiddle', {
            exec:function( editor ){
                // Open the selector widget dialog.
                openRemoteModal( getModuleURL('jsFiddle', 'Home.entry'), {editorName: editor.name} );
            }
        });
        // add button to toolbar
		editor.ui.addButton('cbjsFiddle',{
			label:editor.lang.cbjsFiddle.menu,
			icon: this.path + 'icons/jsfiddle.png',
			command:'cbjsFiddle'
		});
        // Define an editor command that allows modification of the fiddle. 
        editor.addCommand( pluginCmd, {
            exec:function( editor ){
                var selection = editor.getSelection(),
                    element = selection.getStartElement();
                // if IE is confused about the current context, use fallback selection
                if( element.getName()=='p' ) {
                    element = fallbackSelection;
                }
                // Open the selector widget dialog.
                openRemoteModal( getModuleURL('jsFiddle', 'Home.edit'), {
                    url: element.getAttribute( 'src' ),
                    title: element.getText(),
                    height: element.getAttribute( 'height' ),
                    width: element.getAttribute( 'width' ),
                    js: element.getAttribute( 'js' ),
                    html: element.getAttribute( 'html' ),
                    css: element.getAttribute( 'css' ),
                    resources: element.getAttribute( 'resources' ),
                    result: element.getAttribute( 'result' ),
                    editorName: editor.name
                });
            }
        });
		// context menu
		if (editor.addMenuItem) {
			// A group menu is required
			editor.addMenuGroup('contentbox');
			// Create a menu item
			editor.addMenuItem('cbjsFiddle', {
				label: editor.lang.cbjsFiddle.menu,
				command: 'cbjsFiddle',
				icon: this.path + 'icons/jsfiddle.png',
				group: 'contentbox',
				order: 5
			});
            // Register a new context menu group.
			editor.addMenuGroup( 'jsFiddle' );
			// Register a new context menu item for editing existing fiddle.
			editor.addMenuItem( 'jsFiddleItem', {
				// Item label.
				label : editor.lang.cbjsFiddle.edit,
				// Item icon path using the variable defined above.
				icon: this.path + 'icons/jsfiddle.png',
				// Reference to the plugin command name.
				command : pluginCmd,
				// Context menu group that this entry belongs to.
				group : 'clipboard'
			});
		}
        // handle context menu actions
		if (editor.contextMenu) {
            // listener for insert
			editor.contextMenu.addListener(function(element, selection) {
				return { cbjsFiddle: CKEDITOR.TRISTATE_ON };
			});
            // listener for right-click on <fiddle> element (and only <fiddle> element)
			editor.contextMenu.addListener( function( element ) {
				// Get to the closest <fiddle> element that contains the selection.
               if( element.getAscendant( 'div', true ) && element.getId()=='cbjsfiddle' ) {
                   fallbackSelection = element;
                   return { jsFiddleItem: CKEDITOR.TRISTATE_OFF };
               }
			});
		}
	}
});