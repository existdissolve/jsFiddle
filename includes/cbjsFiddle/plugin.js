/*
Copyright (c) 2012 Ortus Solutions, Corp. All rights reserved.
openRemoteModal() is part of ContentBox js
*/
(function(){
	//Section 1 : Code to execute when the toolbar button is pressed
	var a= {
		exec:function(editor){
			// Open the selector widget dialog.
			openRemoteModal( getModuleURL('jsFiddle', 'Home.entry'), {editorName: editor.name} );
		}
	},
	//Section 2 : Create the button and add the functionality to it
	b='cbjsFiddle';
	CKEDITOR.plugins.add(b,{
		init:function(editor){
			editor.addCommand(b,a);
			editor.ui.addButton('cbjsFiddle',{
				label:'Embed a fiddle from jsFiddle',
				icon: this.path + 'jsfiddle.png',
				command:b
			});
			// context menu
			if (editor.addMenuItem) {
				// A group menu is required
				editor.addMenuGroup('contentbox');
				// Create a menu item
				editor.addMenuItem('cbjsFiddle', {
					label: 'Embed jsFiddle',
					command: b,
					icon: this.path + 'jsfiddle.png',
					group: 'contentbox',
					order: 5
				});
			}
			if (editor.contextMenu) {
				editor.contextMenu.addListener(function(element, selection) {
					return { cbjsFiddle: CKEDITOR.TRISTATE_ON };
				});
			}
		}
	});
})();
