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

  if ($('#flickr-pool-slideshow').length > 0) {
    $('#flickr-pool-slideshow').each(function() {
      var element = $(this);
      var key = "40343c1f16327beb5c9adfd73caec372";
      var group_id = element.data("flickr-group");
      var api_method = "flickr.groups.pools.getPhotos&group_id=" + group_id;

      var callback = function(data) {
        if (data.stat == "ok") {
          var data = $.map(data.photos.photo, function(photo) {
            return '<img src="http://farm' + photo.farm + '.static.flickr.com/' + photo.server +'/' + photo.id + '_' + photo.secret + '_m.jpg" />' 
          });
          console.log(data.join('')); 
          element.html(data.join(''));
          element.cycle();
        }
      }

      $.getJSON("http://www.flickr.com/services/rest/?jsoncallback=?&format=json&per_page=10&api_key=" + key + "&method="+ api_method, callback);
    });
  }
});
