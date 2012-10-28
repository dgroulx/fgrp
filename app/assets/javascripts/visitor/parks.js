$(function() {

	var map, markers = [], $canvas = $('#map_canvas');

	var refreshParkList = function(data) {
		var existingMarkers = $canvas.data('markers');
		while (existingMarkers && existingMarkers.length > 0) {
			existingMarkers.pop().setMap(null);
		}

		if (!( data instanceof Array)) {
			data = [data];
		}

		$.each(data, function(i, park) {
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
	
	var buildMap = function(lat, long, zoom, url) {
		var mapOptions = {
			center : new google.maps.LatLng(lat, long), 
			zoom : zoom,
			mapTypeId : google.maps.MapTypeId.ROADMAP,
			disableDefaultUI : true
		};
		map = new google.maps.Map($canvas[0], mapOptions);

		$.getJSON(url, refreshParkList);
	};
	
	// make corners prettier
	for ( i = 0; i < 4; i++) {
		$('aside').append('<span class="concave-corner"></span>')
	}

	// make the amentify multi-select prettier
	var amenitySearch = $('#amenity_id').chosen({
		no_results_text : "No results matched"
	});

	// hook up events for filtering
	$('.search-input').on('change refresh', function(e) {
		var $form = $('#search-form'), $distanceSearch = $('.distance-search'), address = $('#address').val();

		// hack so we don't serialize address field if it's empty
		if (!address) $distanceSearch.prop('disabled', true);
		var data = $form.serialize();
		$distanceSearch.prop('disabled', false);
		$.getJSON('/parks.json', data, refreshParkList);
	});

	$('#address').on('change', function() {
		var geoCoder = new google.maps.Geocoder(), $address = $(this);
		geoCoder.geocode({
			address : $address.val(),
			bounds : map.getBounds()
		}, function(results, status) {
			if (status === google.maps.GeocoderStatus.OK && results && results.length > 0) {
				var address = results[0], location = address.geometry.location;
				map.setCenter(location);
				$('#lat').val(location.lat());
				$('#lng').val(location.lng());
				$address.val(address.formatted_address);
				$('.search-input').trigger('refresh');
			}
		});
	});
	
	$('.filterReset').on('click', function(e) {
		e.preventDefault();
		$('#address').val('');
		$("#amenity_id").val([]); 
		amenitySearch.trigger("liszt:updated");
		$('.search-input').trigger('change');
	});

	// build and populate the map
	if ($("#park_slug").length > 0) {
		// build map for a single park
		var resource = '/parks/' + $("#park_slug").val() + '.json';
		var lat = $("#park_lat").val();
		var lng = $("#park_long").val();
		buildMap(lat, lng, 15, resource);
	} else {
		// build map for all parks in Grand Rapids
		buildMap(42.9633, -85.6681, 12, '/parks.json');
	}

	// set up flickr slideshow
	$('#flickr-pool-slideshow').each(function() {
		var element = $(this);
		var key = "40343c1f16327beb5c9adfd73caec372";
		// david_groulx@me.com's flicker key, need to get a new one
		var group_id = element.data("flickr-group");
		var api_method = "flickr.groups.pools.getPhotos&group_id=" + group_id;

		var callback = function(data) {
			if (data.stat == "ok") {
				var data = $.map(data.photos.photo, function(photo) {
					if (photo.url_n) {
						return '<img src="' + photo.url_n + '" height="' + photo.height_n + '" width="' + photo.width_n +'" />';
					}
					return '<img src="' + photo.url_s + '" height="' + photo.height_s + '" width="' + photo.width_s +'" />';
				});
				element.html(data.join(''));
				element.cycle();
			}
		}

		$.getJSON("http://www.flickr.com/services/rest/?jsoncallback=?&format=json&per_page=20&extras=url_n,url_s&api_key=" + key + "&method=" + api_method, callback);
	});
});
