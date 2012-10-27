$(document).ready(function() {

	var markers = [];
	var $canvas = $('#map_canvas');
	var map;

	var refreshParkList = function(data) {
		var existingMarkers = $canvas.data('markers');
		while (existingMarkers && existingMarkers.length > 0) {
			existingMarkers.pop().setMap(null);
		}

		if (! (data instanceof Array)) {
			data = [data];
		}

		$.each(data, function(i, park) {
			//console.log(park.name + ": " + park.latitude + ", " + park.longitude);
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
		$canvas.data('markers', markers);
	}

	var buildMap = function(lat, long, zoom, url) {
		var mapOptions = {
			center : new google.maps.LatLng(lat, long), // grand rapids lat/long
			zoom : zoom,
			mapTypeId : google.maps.MapTypeId.ROADMAP,
			disableDefaultUI : true
		};
		map = new google.maps.Map($canvas[0], mapOptions);

		$.getJSON(url, refreshParkList);
	};

	$('a.amenity').on('click', function(event) {
		event.preventDefault();
		$.getJSON('parks.json?amenity_id=' + this.id, refreshParkList);
	});

	if ($("#park_slug").val()) {
		var resource = '/parks/' + $("#park_slug").val()  + '.json';
		var lat = $("#park_lat").val();
		var lng = $("#park_long").val();
		buildMap(lat, lng, 15, resource);
	} else {
		buildMap(42.9633, -85.6681, 12, 'parks.json');
	}

	prettify();

});



function prettify(){
  for(i=0;i<4;i++){
    $('aside').append('<span class="concave-corner"></span>')
  }
}
