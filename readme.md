Author 	 :	Joel Watson
Description :

This module allows you to insert fiddles from multiple users from http://jsfiddle.net.

About
=====
The jsFiddle module for ContentBox is a simple, but handy way to easily embed “fiddles” from http://jsfiddle.net in your posts and pages. It also provides for some nice configuration of defaults so that you concentrate more on your content and less on tweaking the fiddles that you include in your posts.

Features
========
Module Configuration
--------------------
Defaults

* jsFiddle allows defaults to be set for the following:
* iFrame height
* iFrame width
* Cache duration (how often fiddles should be refreshed for saved users)
* jsFiddle “tabs” to be included in the fiddle
 * Fiddle Result
 * JavaScript
 * CSS
 * HTML
 * Resources

Users

Another really handy feature of the jsFiddle module is that you can save any number of usernames from http://jsfiddle.net. Once saved, you will be able to browse the user’s public fiddles when inserting a fiddle into your posts and pages.

NOTE: If you want to force a refresh of all users’ fiddles regardless of expiration, simply use the “Update Cached Fiddles” option.

Using jsFiddle
==============
Inserting Fiddles
-----------------
A new icon is added to the CKEditor toolbar when creating and editing pages and posts.

Also, you can right-click in the editing area and choose “Embed jsFiddle”.

After acting via the toolbar icon OR the context menu, you’ll see a simple wizard for inserting fiddles. This wizard provides two options.

User Fiddles

In this wizard, you can select a user from the selection list (assuming you’ve saved some users in the config). Once you’ve selected a user, their available public fiddles will displayed.

To insert a fiddle, click the “Configure” link. You’ll see a variety of options (all of which should reflect the defaults you’ve set in the module configuration). You can override any defaults you like. Once you have the fiddle configured the way you’d like it, simply click “Insert FIddle”, and your configured fiddle will be inserted into the content area.

Fiddle By URL

Perhaps you’ve come across a fiddle you want to embed, but haven’t set up the user yet. No problem. With the FIddle By URL option, you can insert a fiddle simply by providing the URL.

Editing Fiddles
===============
Whether you need to increase the height of the iFrame, or tweak the “tabs” that are included in the fiddle, there are a lot of reasons you might want to edit the properties of a fiddle that you’ve already embedded. Fortunately, this is very simple to do.
In the content editor, simply right-click on the fiddle you’d like to edit. In the context menu that appears, you should see a “Edit Fiddle” option at the top.
Once you click this option, a configuration window will be displayed, allowing you easily modify the properties of the fiddle.

======================================================================
CHANGELOG
======================================================================

Version 1.0
# Initial Release