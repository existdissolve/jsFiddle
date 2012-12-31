<cfoutput>
<style type="text/css">
	.jsfiddleuser {
	    width: 300px;border: solid 1px ##dadada;border-radius: 4px;list-style:none;padding:5px 10px;
        background: ##45484d; /* Old browsers */
        background: -moz-linear-gradient(top, ##45484d 0%, ##000000 100%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,##45484d), color-stop(100%,##000000)); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(top, ##45484d 0%,##000000 100%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(top, ##45484d 0%,##000000 100%); /* Opera 11.10+ */
        background: -ms-linear-gradient(top, ##45484d 0%,##000000 100%); /* IE10+ */
        background: linear-gradient(to bottom, ##45484d 0%,##000000 100%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='##45484d', endColorstr='##000000',GradientType=0 ); /* IE6-9 */
        color: ##fafafa;
        margin: 5px 1px;
    }
    .jsfiddleuser span {font-weight:bold;}
    .jsfiddleuser img {margin:-1px 5px 0 0;cursor:pointer;}
    input[name=jsfiddleuser] {width:309px;}
</style>
<script type="text/javascript">
$(document).ready(function() {
	// form validators
	$("##settingsForm").validator();
    $( 'img.add_jsfiddleuser' ).click( addUser );
    $( 'img.delete_jsfiddleuser' ).live( 'click', function(){
        removeUser( $( this ).next()[0].innerHTML );
    });
    
    function userExists( user, users ) {
        for( var i in users ) {
            var targetuser = users[i];
            if( user==targetuser ) {
                return true;
            }
        }
        return false;
    }
    
    function addUser() {
        var fld = $( 'input[name=jsfiddleuser]' )[0],
            hiddenFld = $( 'input[name=users]' )[0],
            users = hiddenFld.value.split( ',' ),
            list = $( 'ul.jsfiddleusers' ),
            user='';
        // if a value is entered, add a new user
        if( fld.value != '' ) {
            // first, check if user already exists in list
            if( !userExists( fld.value, users ) ) {
                // add user to array
                users.push( fld.value );           
                // put new value on setting field
                hiddenFld.value = users.join( ',' );
                // finally, add user to visual list with delete button
                list.append( createLI( fld.value ) ); 
                // clear fld value
                fld.value = '';   
            }
            else {
                alert( 'Sorry, that user already exists.' );
            }
        }
    }
    
    function removeUser( user ) {
        var hiddenFld = $( 'input[name=users]' )[0],
            users = hiddenFld.value.split( ',' ),
            list = $( 'ul.jsfiddleusers' ),
            pos = jQuery.inArray( user, users );
        // remove from array
        users.splice( pos, 1 );
        // put new value on setting field
        hiddenFld.value = users.join( ',' );
        // remove from visual list
        list.empty();
        for( var i in users ) {
            list.append( createLI( users[i] ) );
        }
    }
    
    function createLI( user ) {
        var html = '<li class="jsfiddleuser"><img height="16" src="#event.getModuleRoot('jsFiddle')#/includes/delete.png" class="delete_jsfiddleuser" /><span>';
        html += user;
        html += '</span></li>';
        return html;
    }
});
</script>
</cfoutput>