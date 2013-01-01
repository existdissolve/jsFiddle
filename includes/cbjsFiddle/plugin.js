(function(){
	//Section 1 : Code to execute when the toolbar button is pressed
	var a= {
		exec:function( editor ){
			// Open the selector widget dialog.
			openRemoteModal( getModuleURL('jsFiddle', 'Home.entry'), {editorName: editor.name} );
		}
	};
	//Section 2 : Create the button and add the functionality to it
	CKEDITOR.plugins.add('cbjsFiddle',{
		init:function( editor ){
            // add a custom stylesheet to the editor so we can style the <fiddle> tag
            CKEDITOR.config.contentsCss = typeof CKEDITOR.config.contentsCss=='object' ? CKEDITOR.config.contentsCss.push( this.path + 'editor.css' ) : [CKEDITOR.config.contentsCss, this.path + 'editor.css'];
            // add insert command
			editor.addCommand( 'cbjsFiddle', a );
            // add button to toolbar
			editor.ui.addButton('cbjsFiddle',{
				label:'Embed a fiddle from jsFiddle',
				icon: this.path + 'jsfiddle.png',
				command:'cbjsFiddle'
			});
            // Define an editor command that allows modification of the fiddle. 
		    editor.addCommand( 'fiddleDialog', new CKEDITOR.dialogCommand( 'fiddleDialog' ) );
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
            // create new dialog for editing fiddle
            CKEDITOR.dialog.add( 'fiddleDialog', function ( editor ){
    			return {
    				// Basic properties of the dialog window: title, minimum size.
    				title : 'Edit jsFiddle',
    				minWidth : 400,
    				minHeight : 200,
    				// Dialog window contents.
    				contents :
    				[
    					{
    						// Definition of the Basic Settings dialog window tab (page) with its id, label and contents.
    						id : 'tab1',
    						label : 'Basic Settings',
    						elements :
    						[
    							{
    								// Dialog window UI element: a text input field.
    								type : 'text',
    								id : 'url',
    								// Text that labels the field.    								
    								label : 'URL',
    								// Validation checking whether the field is not empty.
    								validate : CKEDITOR.dialog.validate.notEmpty( "URL field cannot be empty" ),
    								// Function to be run when the setupContent method of the parent dialog window is called.
    								// It can be used to initialize the value of the field.
    								setup : function( element ) {
    									this.setValue( element.getAttribute( 'src' ) );
    								},
    								// Function to be run when the commitContent method of the parent dialog window is called.
    								// Set the element's text content to the value of this field.
    								commit : function( element ) {
    									element.setAttribute( 'src', this.getValue() );
    								}
    							},
                                {
    								// Dialog window UI element: a text input field.
    								type : 'text',
    								id : 'width',
    								// Text that labels the field.    								
    								label : 'Width',
    								// Validation checking whether the field is not empty.
    								validate : CKEDITOR.dialog.validate.notEmpty( "Width field cannot be empty" ),
    								// Function to be run when the setupContent method of the parent dialog window is called.
    								// It can be used to initialize the value of the field.
    								setup : function( element ) {
    									this.setValue( element.getAttribute( 'width' ) );
    								},
    								// Function to be run when the commitContent method of the parent dialog window is called.
    								// Set the element's text content to the value of this field.
    								commit : function( element ) {
    									element.setAttribute( 'width', this.getValue() );
    								}
    							},
    							{
    								// Dialog window UI element: a text input field.
    								type : 'text',
    								id : 'height',
    								// Text that labels the field.    								
    								label : 'Height',
    								// Validation checking whether the field is not empty.
    								validate : CKEDITOR.dialog.validate.notEmpty( "Height field cannot be empty" ),
    								// Function to be run when the setupContent method of the parent dialog window is called.
    								// It can be used to initialize the value of the field.
    								setup : function( element ) {
    									this.setValue( element.getAttribute( 'height' ) );
    								},
    								// Function to be run when the commitContent method of the parent dialog window is called.
    								// Set the element's text content to the value of this field.
    								commit : function( element ) {
    									element.setAttribute( 'height', this.getValue( ) );
    								}
    							},
                                {
                                    type: 'hbox',
                                    label: 'Tabs',
                                    widths: ['12%','15%','15%','15%','43%'],
                                    children: [
                                        {
            								// Dialog window UI element: a text input field.
            								type : 'checkbox',
            								id : 'result',
            								// Text that labels the field.    								
            								label : 'Result',
            								// Function to be run when the setupContent method of the parent dialog window is called.
            								// It can be used to initialize the value of the field.
            								setup : function( element ) {
                                                var checked = element.getAttribute( 'result' );
                                                //this.setValue( element.getAttribute( 'html' ) );
                                                if( checked=='true' ) {
                                                    if( this.getInputElement().hasAttribute( 'checked' ) ) {
                                                        this.getInputElement().setAttribute( 'checked', true );
                                                    }
                                                    else {
                                                        this.getInputElement().$.checked = true;
                                                    }
                                                }
                                                else {
                                                    this.getInputElement().removeAttribute( 'checked' );
                                                }
            								},
            								// Function to be run when the commitContent method of the parent dialog window is called.
            								// Set the element's text content to the value of this field.
            								commit : function( element ) {
            									element.setAttribute( 'result', this.getValue( ) );
            								}
            							},              
                                        {
            								// Dialog window UI element: a text input field.
            								type : 'checkbox',
            								id : 'js',
            								// Text that labels the field.    								
            								label : 'JS',
            								// Function to be run when the setupContent method of the parent dialog window is called.
            								// It can be used to initialize the value of the field.
            								setup : function( element ) {
            									var checked = element.getAttribute( 'js' );
                                                //this.setValue( element.getAttribute( 'html' ) );
                                                if( checked=='true' ) {
                                                    if( this.getInputElement().hasAttribute( 'checked' ) ) {
                                                        this.getInputElement().setAttribute( 'checked', true );
                                                    }
                                                    else {
                                                        this.getInputElement().$.checked = true;
                                                    }
                                                }
                                                else {
                                                    this.getInputElement().removeAttribute( 'checked' );
                                                }
            								},
            								// Function to be run when the commitContent method of the parent dialog window is called.
            								// Set the element's text content to the value of this field.
            								commit : function( element ) {
            									element.setAttribute( 'js', this.getValue( ) );
            								}
            							},
                                        {
            								// Dialog window UI element: a text input field.
            								type : 'checkbox',
            								id : 'resources',
            								// Text that labels the field.    								
            								label : 'Resources',
            								// Function to be run when the setupContent method of the parent dialog window is called.
            								// It can be used to initialize the value of the field.
            								setup : function( element ) {
            									var checked = element.getAttribute( 'resources' );
                                                //this.setValue( element.getAttribute( 'html' ) );
                                                if( checked=='true' ) {
                                                    if( this.getInputElement().hasAttribute( 'checked' ) ) {
                                                        this.getInputElement().setAttribute( 'checked', true );
                                                    }
                                                    else {
                                                        this.getInputElement().$.checked = true;
                                                    }
                                                }
                                                else {
                                                    this.getInputElement().removeAttribute( 'checked' );
                                                }
            								},
            								// Function to be run when the commitContent method of the parent dialog window is called.
            								// Set the element's text content to the value of this field.
            								commit : function( element ) {
            									element.setAttribute( 'resources', this.getValue( ) );
            								}
            							},
                                        {
            								// Dialog window UI element: a text input field.
            								type : 'checkbox',
            								id : 'css',
            								// Text that labels the field.    								
            								label : 'CSS',
            								// Function to be run when the setupContent method of the parent dialog window is called.
            								// It can be used to initialize the value of the field.
            								setup : function( element ) {
            									var checked = element.getAttribute( 'css' );
                                                //this.setValue( element.getAttribute( 'html' ) );
                                                if( checked=='true' ) {
                                                    if( this.getInputElement().hasAttribute( 'checked' ) ) {
                                                        this.getInputElement().setAttribute( 'checked', true );
                                                    }
                                                    else {
                                                        this.getInputElement().$.checked = true;
                                                    }
                                                }
                                                else {
                                                    this.getInputElement().removeAttribute( 'checked' );
                                                }
            								},
            								// Function to be run when the commitContent method of the parent dialog window is called.
            								// Set the element's text content to the value of this field.
            								commit : function( element ) {
            									element.setAttribute( 'css', this.getValue( ) );
            								}
            							},
                                        {
            								// Dialog window UI element: a text input field.
            								type : 'checkbox',
            								id : 'html',
            								// Text that labels the field.    								
            								label : 'HTML',
            								// Function to be run when the setupContent method of the parent dialog window is called.
            								// It can be used to initialize the value of the field.
            								setup : function( element ) {
                                                var checked = element.getAttribute( 'html' );
                                                //this.setValue( element.getAttribute( 'html' ) );
                                                if( checked=='true' ) {
                                                    if( this.getInputElement().hasAttribute( 'checked' ) ) {
                                                        this.getInputElement().setAttribute( 'checked', true );
                                                    }
                                                    else {
                                                        this.getInputElement().$.checked = true;
                                                    }
                                                }
                                                else {
                                                    this.getInputElement().removeAttribute( 'checked' );
                                                }
            								},
            								// Function to be run when the commitContent method of the parent dialog window is called.
            								// Set the element's text content to the value of this field.
            								commit : function( element ) {
            									element.setAttribute( 'html', this.getValue( ) );
            								}
            							}   
                                    ]
                                }
    						]
    					}
    				],
    				// This method is invoked once a dialog window is loaded. 
    				onShow : function()
    				{
    					// Get the element selected in the editor.
    					var sel = editor.getSelection(),
    					// Assigning the element in which the selection starts to a variable.
    						element = sel.getStartElement();
    					
    					// Get the <abbr> element closest to the selection.
    					if ( element )
    						element = element.getAscendant( 'fiddle', true );
    					
    					// Create a new <fiddle> element if it does not exist.
    					// For a new <fiddle> element set the insertMode flag to true.
    					if ( !element || element.getName() != 'fiddle' || element.data( 'cke-realelement' ) )
    					{
    						element = editor.document.createElement( 'fiddle' );
    						this.insertMode = true;
    					}
    					// If an <fiddle> element already exists, set the insertMode flag to false.
    					else
    						this.insertMode = false;
    					
    					// Store the reference to the <abbr> element in a variable.
    					this.element = element;
    					
    					// Invoke the setup functions of the element.
    					this.setupContent( this.element );
    				},				
    				// This method is invoked once a user closes the dialog window, accepting the changes.
    				onOk : function()
    				{
    					// A dialog window object.
    					var dialog = this,
    						abbr = this.element;
    					
    					// If we are not editing an existing fiddle element, insert a new one.
    					if ( this.insertMode )
    						editor.insertElement( abbr );
    					
    					// Populate the element with values entered by the user (invoke commit functions).
    					this.commitContent( abbr );
    				}
    			};
    		} );
		}
	});
})();
