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
		$('.parkCount').html(markers.length);
	}
	
	var buildMap = function(lat, lng, zoom, url) {
		var mapOptions = {
			center : new google.maps.LatLng(lat, lng), 
			zoom : zoom,
			mapTypeId : google.maps.MapTypeId.ROADMAP,
			disableDefaultUI : true
		};
		map = new google.maps.Map($canvas[0], mapOptions);

		$.getJSON(url, refreshParkList);
	};

	$('select.amenities').chosen({no_results_text: "No results matched"}).change(function(e) {
		var selected = $(this).val(); 
		if (selected && selected.length > 0) {
			var resource = 'parks.json?';
			$.each(selected, function(i) {
				if (i > 0) resource += '&';
				resource += 'amenity_id=' + this;
			});
		}
		$.getJSON(resource, refreshParkList);
	});
	
	if ($("#park_slug").val()) {
		var resource = '/parks/' + $("#park_slug").val()  + '.json';
		var lat = $("#park_lat").val();
		var lng = $("#park_long").val();
		buildMap(lat, lng, 15, resource);
		
		var treemapOptions = {
			center : new google.maps.LatLng(lat, lng), 
			zoom : 15,
			mapTypeId : google.maps.MapTypeId.SATELLITE,
			disableDefaultUI : true
		};
		var treemap = new google.maps.Map($('#treemap_canvas')[0], treemapOptions);
		
		 plotsLayer = new google.maps.KmlLayer('/plots.kml');
		plotsLayer.setMap(treemap);
		
		
		
		// $.getJSON('/ufp.json?lat=' + lat + '&lng=' + lng, function(data) {
			// $.each(data.geography.coordinates[0], function(i, coords) {
				// console.log(coords);
				// var marker = new google.maps.Marker({
					// position : new google.maps.LatLng(coords[1], coords[0]),
					// map : treemap,
					// animation : google.maps.Animation.DROP
				// });
			// });
		// });
		
		
	} else {
		buildMap(42.9633, -85.6681, 12, 'parks.json');  // grand rapids lat/long
	}
});
