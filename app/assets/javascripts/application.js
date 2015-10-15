// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require toastr
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require_tree .

var user_type = "";
$(document).ready(function(){
	//CHECKIN PAGE FUNCTIONS

	//bind to radio butttons to shwo the correct fields
	$('[name=optradio]').change(function(e){
		user_type = $(e.currentTarget).attr("value");
		if (user_type == "student"){
			$("#student-questions").show();
			$("#parent-questions").hide();
		}
		else{ //parent
			$("#student-questions").hide();
			$("#parent-questions").show();
		}
		//show remaining questions
		$(".other-questions").show();
		if ($("#reason").val() == "other"){
			$("#other-text").show();
		}
	});

	//bind to the reasons field to show the other-text field if the Other option is selected
	$("#reason").change(function(){
		if ($("#reason").val() == "other"){
			$("#other-text").show();
		}
		else{
			$("#other-text").hide();
		}
	});

	$("#visiting").change(function(){
		var val = $("#visiting").val();
		$("#aboutWrapper").hide();
		//get the reasons of that user
		$.get("/api/users/"+val+"/reasons")
		.success(function(data){
			console.log(data);
			//populate the about entry
			html = "<option value=''></option>";

			for(var i = 0; i < data.length; i++)
			{
				html += "<option value='"+data[i].id+"'>"+data[i].text+"</option>";
			}
			html += "<option value='other'>Other</option>";
			$("#reason").val("");
			$("#reason").html(html);
			$("#aboutWrapper").show();
		})
		.error(function(error){
			console.log(error);
		});
	});

	//handle submit
	$("#checkin-submit").click(function(){
		//check that all values are filled out
		var name = $("#name").val();
		var visiting = $("#visiting").val();
		var reason = $("#reason").val();
		if (reason === "other")
			var custom_reason = true;
		else
			var custom_reason = false;
		var custom_reason_text = $("#other-text").val();
		if (user_type == "student"){
			var badge = $("#badge").val();
			if (name === "" || visiting === "" || reason === "" || badge === "")
				toastr.error("All Fields Are Required");
			else{
				$.post("/api/checkin",{
					name: name,
					user_id: visiting,
					reason_id: reason,
					user_type: user_type,
					badge_id: badge,
					custom_reason: custom_reason,
					custom_reason_text: custom_reason_text,
					school: window.location.pathname.replace("/","")
				})
				.success(function(data){
					console.log(data);
					//reset the form
					toastr.success("You are checked in!");
					setTimeout(function(){
						location.reload();
					}, 5000);
				})
				.error(function(error){
					toastr.error("ERROR!");
				});
			}
		}
		else{ //parent
			var student_name = $("#student-name").val();
			if (name === "" || visiting === "" || reason === "" || student_name === "")
				toastr.error("All Fields Are Required");
			else{
				$.post("/api/checkin",{
					name: name,
					user_id: visiting,
					reason_id: reason,
					user_type: user_type,
					student_name: student_name,
					custom_reason: custom_reason,
					custom_reason_text: custom_reason_text,
					school: window.location.pathname.replace("/","")
				})
				.success(function(data){
					console.log(data);
					//reset the form
					toastr.success("You are checked in!");
					setTimeout(function(){
						location.reload();
					}, 5000);
				})
				.error(function(error){
					toastr.error("ERROR: ");
					//TODO: make this show the actual errors
				});
			}
		}
	});

	//ADMIN PAGE FUNCTIONS
	$("label.btn").click(function(e){
		//propogate the click even down to the child element defined below
		$(e.currentTarget).children()[0].click();
	});
	$("#checkins_btn").click(function(){
		showCheckinsPage();
	});
	$("#settings_btn").click(function(){
		showSettingsPage();
	});
	$("#users_btn").click(function(){
		showUsersPage();
	});


	// SETTINGS SUB-PAGE functions
	$("#new_reason").click(function(){
		if ($("#reason_text").val() !== "")
		{
			$.post("/api/reasons",{
				text: $("#reason_text").val(),
				school: window.location.pathname.replace("/","").split("/")[0]
			})
			.success(function(data){
				//reload the page
				window.location = window.location.pathname + "?page=settings";
			})
			.error(function(error){
				console.log(error);
			})
		}
		else
			toastr.error("You must fill out the New Reason field");
	});

	$(".delete_reason").click(function(e){
		confirm("Are you sure you want to remove this reason?");
		var id = $(e.currentTarget).attr("id").split("_")[1];
		console.log(id);
		$.post("/api/reasons/"+id+"/delete")
		.success(function(){
			window.location = window.location.pathname + "?page=settings";
		})
		.error(function(){
			toastr.error("Couln't delete the reason. Please try again later");
		});
	});

	$("#new_user").click(function(){
		if ($("#honorific").val() !== "" && $("#name").val() !== "" && $("#role").val() !== "" && $("#email").val() !== "")
		{
			$.post("/api/users",{
				honorific: $("#honorific").val(),
				name: $("#name").val(),
				is_admin: $("#role").val(),
				email: $("#email").val(),
				school: window.location.pathname.replace("/","").split("/")[0]
			})
			.success(function(data){
				//reload the page
				window.location = window.location.pathname + "?page=users";
			})
			.error(function(error){
				console.log(error);
			})
		}
		else
			toastr.error("All Fields Are Required");
	});

	$(".delete_user").click(function(e){
		confirm("Are you sure you want to remove this user?");
		var id = $(e.currentTarget).attr("id").split("_")[1];
		console.log(id);
		$.post("/api/users/"+id+"/delete")
		.success(function(){
			window.location = window.location.pathname + "?page=users";
		})
		.error(function(){
			toastr.error("Couln't delete the user. Please try again later");
		});
	});

	if (window.location.pathname.split("/")[2] == "admin"){ //on the admin page
		$("#checkins").show();
		//see if we need to set a different page, and set the page
		if (QueryString.page !== undefined){
			var page = QueryString.page
			if (page === "settings")
				$("#settings_btn").click();
			else if (page === "users")
				$("#users_btn").click();
			else
				$("#checkins_btn").click();
		}
		else
			$("#checkins_btn").click();
	}
	$.fn.editable.defaults.mode = 'inline';
    $('.editable').editable();
    $('.editable-title').editable({  
        source: [
              {value: "Dr.", text: 'Dr.'},
              {value: "Mr.", text: 'Mr.'},
              {value: "Mrs.", text: 'Mrs.'},
              {value: "Ms.", text: 'Ms.'}
           ]
    });
    $('.editable-is-admin').editable({  
        source: [
              {value: "true", text: 'Admin'},
              {value: "false", text: 'User'}
           ]
    });
});

function showCheckinsPage(){
	$("#checkins").show();
	$("#settings").hide();
	$("#users").hide();
}

function showSettingsPage(){
	$("#checkins").hide();
	$("#settings").show();
	$("#users").hide();
}

function showUsersPage(){
	$("#checkins").hide();
	$("#settings").hide();
	$("#users").show();
}


var QueryString = function () {
  // This function is anonymous, is executed immediately and 
  // the return value is assigned to QueryString!
  var query_string = {};
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
        // If first entry with this name
    if (typeof query_string[pair[0]] === "undefined") {
      query_string[pair[0]] = decodeURIComponent(pair[1]);
        // If second entry with this name
    } else if (typeof query_string[pair[0]] === "string") {
      var arr = [ query_string[pair[0]],decodeURIComponent(pair[1]) ];
      query_string[pair[0]] = arr;
        // If third or later entry with this name
    } else {
      query_string[pair[0]].push(decodeURIComponent(pair[1]));
    }
  } 
    return query_string;
}();