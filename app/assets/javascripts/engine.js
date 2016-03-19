$(document).ready(function() {
    $("#contacts-tagit").tagit();
});

function send_emails() {
	var emails;
	emails = $("span.tagit-label").map(function () {
	  return $(this).text();
	}).get().join();
	$.ajax({
	  type: 'POST',
	  dataType: 'script',
	  data: { emails: emails },      
	  url: "/send_member_invites",
	  complete: function(){
	    $("#contacts-tagit").tagit("removeAll");
	  }      
	});
}