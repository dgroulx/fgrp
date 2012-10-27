$(document).ready(function() {

	// TODO: remove me
	$.getScript("/parks/" + $("#park_slug").val() + ".js");

	var grLatLong = new google.maps.LatLng(42.9633, -85.6681);
	var mapOptions = {
		center : grLatLong,
		zoom : 12,
		mapTypeId : google.maps.MapTypeId.ROADMAP,
		disableDefaultUI : true
	};

	var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	var markers = [];

	$.getJSON('parks.json', function(data) {
		$.each(data, function(i, park) {
			console.log(park.name + ": " + park.latitude + ", " + park.longitude);
			var marker = new google.maps.Marker({
				position : new google.maps.LatLng(park.latitude, park.longitude),
				map : map,
				animation : google.maps.Animation.DROP,
				title : park.name
			});
			google.maps.event.addListener(marker, 'click', function() {
				location.href = "/parks/" + park.slug;
			});
			markers.push(marker);
		});
	});

});
