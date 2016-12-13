// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require underscore
//= require gmaps/google
var map_forms = document.getElementsByClassName("map-form");
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
}
// } else {
//     x.innerHTML = "Geolocation is not supported by this browser.";
// }

function showPosition(position) {
    if(!localStorage["lat"] || !localStorage["lng"]) {
        console.log("STORING");
        localStorage["lat"] = position.coords.latitude;
        localStorage["lng"] = position.coords.longitude;
    }
    for(var i = 0; i < map_forms.length; ++i) {
        map_forms[i].lat.value = localStorage["lat"];
        map_forms[i].lng.value = localStorage["lng"];
        console.log("SETTING VALUES");
        console.log(map_forms[i].lat.value);
        console.log(map_forms[i].lng.value);
    }
}