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

});