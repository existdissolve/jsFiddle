(function(){
	//Section 1 : Code to execute when the toolbar button is pressed
	var a= {
		exec:function( editor ){
			// Open the selector widget dialog.
			openRemoteModal( getModuleURL('jsFiddle', 'Home.entry'), {editorName: editor.name} );
		}
	};
    var b= {
		exec:function( editor ){
            var element = editor.getSelection().getStartElement();
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
	};
	//Section 2 : Create the button and add the functionality to it
	CKEDITOR.plugins.add('cbjsFiddle',{
		init:function( editor ){
            // add a custom stylesheet to the editor so we can style the <fiddle> tag
            if( typeof CKEDITOR.config.contentsCss=='object' ) {
                CKEDITOR.config.contentsCss.push( this.path + 'editor.css' );
            }  
            else {
                CKEDITOR.config.contentsCss = [CKEDITOR.config.contentsCss, this.path + 'editor.css'];
            }           
            // add insert command
			editor.addCommand( 'cbjsFiddle', a );
            // add button to toolbar
			editor.ui.addButton('cbjsFiddle',{
				label:'Embed a fiddle from jsFiddle',
				icon: this.path + 'jsfiddle.png',
				command:'cbjsFiddle'
			});
            // Define an editor command that allows modification of the fiddle. 
		    //editor.addCommand( 'fiddleDialog', new CKEDITOR.dialogCommand( 'fiddleDialog' ) );
            editor.addCommand( 'fiddleDialog', b )
			// context menu
			if (editor.addMenuItem) {
				// A group menu is required
				editor.addMenuGroup('contentbox');
				// Create a menu item
				editor.addMenuItem('cbjsFiddle', {
					label: 'Embed jsFiddle',
					command: 'cbjsFiddle',
					icon: this.path + 'jsfiddle.png',
					group: 'contentbox',
					order: 5
				});
                // Register a new context menu group.
    			editor.addMenuGroup( 'jsFiddle' );
    			// Register a new context menu item for editing existing fiddle.
    			editor.addMenuItem( 'jsFiddleItem',
    			{
    				// Item label.
    				label : 'Edit Fiddle',
    				// Item icon path using the variable defined above.
    				icon: this.path + 'jsfiddle.png',
    				// Reference to the plugin command name.
    				command : 'fiddleDialog',
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
    				if ( element )
    					element = element.getAscendant( 'fiddle', true );
    				// Return a context menu object in an enabled, but not active state.
    				if ( element && !element.isReadOnly() && !element.data( 'cke-realelement' ) )
    		 			return { jsFiddleItem : CKEDITOR.TRISTATE_ON };
    				// Return nothing if the conditions are not met.
    		 		return null;
    			});
			}
		}
	});
})();