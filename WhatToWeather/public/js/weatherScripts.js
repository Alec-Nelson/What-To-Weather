$(document).ready(function(){
      // $("#wtext").text("weather");
      // $("#weather").css("display", "inline");
      // document.getElementById("item1").innerHTML = "Item was changed";
  displayWeather();

  // event handler for username textbox on Register page
  //blur activates when you click away from element
  $('#register #uname').blur(function(){
    var textbox = $(this); // remember our trigger textbox

    // first, remove any status classes attached to this textbox
    $(textbox).removeClass('unavailable').removeClass('available');

    // ajax GET request to see if username is available
    $.get(
      'signup/check/?',
      { "username": $(textbox).val() }, "json")
      .done(function(data){
          // alert( "Data Loaded: " + data );
        if(data.success == 'success') {
          // successfully reached the server
          if(data.check == 'available') {
            $(textbox).addClass('available');
            $("#userStatus").html("User Name is Available<br/>");
            $("#userStatus").css("color", "green");
            $('#signUpButton').prop('disabled', false);
          } else {
            $("#userStatus").html("User Name is Not Available<br/>");
            $("#userStatus").css("color", "red");
            $(textbox).addClass('unavailable');
            $('#signUpButton').prop('disabled', true);
          }
        } else if(data.error != '') {
          alert("Please provide a valid username.");
        } })
      .fail(function(jqXHR, textStatus, errorThrown){
          console.log(jqXHR);
          console.log(textStatus);
          console.log(errorThrown);
          alert("Ajax error: could not reach server. " + errorThrown);
      });
  });


    $("#submitClothingButton").click(function()
    {

      $.post(
        'submit/?',
        {
          "clothingname": $('#nameClothing').val(),
          "clothingtype": $('#typeClothing').val(),
          "tempmin": $('#tempMin').val(),
          "tempmax": $('#tempMax').val()
         }, "json")
        .done(function(data){
          if(data.success == 'success') {
            $('#listOfClothes').append("<p class='listOfClothes'>Type: " + data.type + "\tMin Temp: " + data.min + "\tMax Temp: " + data.max + "\tName: " + data.name +"\n</p>");
            $('#clothesTable').append("<tr><td>" + data.type + "</td><td>" + data.min + "</td><td>" + data.max + "</td><td>" + data.name +"</td></tr>");
          }else if(data.error != '') {
            alert("Please provide valid Entries for all Text Boxes.");
          }
      })
      .fail(function(jqXHR, textStatus, errorThrown){
          console.log(jqXHR);
          console.log(textStatus);
          console.log(errorThrown);
      alert("Ajax error: could not reach server. " + errorThrown);
      });
  });


	//Log in Button is pressed
   $("#logInButton").click(function()
   {
   		//if no username is entered adds
   		//info on correctly entering username
   		//also makes text backround red
        if ($("#logInUserName").val() == "")
        	{
        		$("#logInUserName").css("background", "red");
        		$("#logInUserName").css("color", "black");
        		$("#logInPassword").css("background", "red");
        		$("#logInPassword").css("color", "black");
        		alert("Please Enter a valid User Name");
        		$("p").prepend("Please Enter a valid User Name <br />");
        	}
    });


   // //Sign in Button is pressed
   // $("#signUpButton").click(function()
   // {
   // 		//sends to sign up page
   //      window.location.href = "SignUp.html";
   //  });



});
function showPosition(position) {
    return "Latitude: " + position.coords.latitude + 
    "Longitude: " + position.coords.longitude; 
}

function printWeather(lat, lon)
{
  $.get('http://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&APPID=2cb0248de8eaed19d67ff5e2239271ed&units=imperial',
              {}, "json")
              .done(function(data){
                // $("#wicon").attr("src", "http://openweathermap.org/img/w/"+data.weather[0].icon+".png")
                 // " H:" + Math.round(data.main.temp_max) + "\xB0 L:"+Math.round(data.main.temp_min)+"\xB0"
                $("#wtext").text("Currently " +data.weather[0].main +" and " + Math.round(data.main.temp)+ "\xB0 in " +data.name);
                $("#weather").css("display", "inline");
               })
              .fail(function(jqXHR, textStatus, errorThrown){
                  console.log(jqXHR);
                  console.log(textStatus);
                  console.log(errorThrown);
                  // alert("Ajax error: could not reach server. " + errorThrown);
              });

}
function success(position){
  printWeather( position.coords.latitude, position.coords.longitude);

}

function error(error){
          switch(error.code) {
          case error.PERMISSION_DENIED:
              window.alert("User denied the request for Geolocation.");
              break;
          case error.POSITION_UNAVAILABLE:
              window.alert("Location information is unavailable.");
              break;
          case error.TIMEOUT:
              window.alert("The request to get user location timed out.");
              break;
          case error.UNKNOWN_ERROR:
              window.alert("An unknown error occurred.");
              // break;
      }
}

function displayWeather(){
  if (window.navigator && window.navigator.geolocation) {
     // I can watch you wherever you go...
     var lat;
     var lon;
     var geolocation = window.navigator.geolocation;
     geolocation.getCurrentPosition(success,error);
  }
}
