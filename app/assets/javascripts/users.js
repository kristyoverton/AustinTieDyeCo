$(document).on('click',"#checkIn", function(e){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(pos){
                $('#location_lat').val(pos.coords.latitude);
                $('#location_long').val(pos.coords.longitude);
        	});
    } else {
        alert("Sorry, geolocation is not supported by this browser.");
    } 
});


