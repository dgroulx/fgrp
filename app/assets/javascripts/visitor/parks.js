$(function () {

    var map,
        markers = [],
        $canvas = $('#map_canvas');

    var refreshParkList = function (data) {
        var existingMarkers = $canvas.data('markers');
        while (existingMarkers && existingMarkers.length > 0) {
            existingMarkers.pop().setMap(null);
        }

        if (!(data instanceof Array)) {
            data = [data];
        }

        $.each(data, function (i, park) {
            //console.log(park.name + ": " + park.latitude + ", " + park.longitude);
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(park.latitude, park.longitude),
                map: map,
                animation: google.maps.Animation.DROP,
                title: park.name
            });
            google.maps.event.addListener(marker, 'click', function () {
                location.href = "/parks/" + park.slug;
            });
            markers.push(marker);
        });
        $canvas.data('markers', markers);
        $('.parkCount').html(markers.length);
    }

    var buildMap = function (lat, long, zoom, url) {
        var mapOptions = {
            center: new google.maps.LatLng(lat, long), // grand rapids lat/long
            zoom: zoom,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true
        };
        map = new google.maps.Map($canvas[0], mapOptions);

        $.getJSON(url, refreshParkList);
    };

    $('.search-input').on('change refresh', function (e) {
        var $form = $('#search-form'),
            $distanceSearch = $('.distance-search'),
            address = $('#address').val();

        if (!address) {
            $distanceSearch.prop('disabled', true);
        }

        var data = $form.serialize();

        $distanceSearch.prop('disabled', false);

        $.getJSON('/parks.json', data, refreshParkList);
    });

    $('#amenity_id').chosen({ no_results_text: "No results matched" });

    $('#address').on('change', function () {
        var geoCoder = new google.maps.Geocoder(),
            $address = $(this);
        geoCoder.geocode({ address: $address.val(), bounds: map.getBounds() }, function (results, status) {
            if (status === google.maps.GeocoderStatus.OK && results && results.length > 0) {
                var address = results[0],
                    location = address.geometry.location;
                map.setCenter(location);
                $('#lat').val(location.lat());
                $('#lng').val(location.lng());
                $address.val(address.formatted_address);
                $('.search-input').trigger('refresh');
            }
        });
    });

prettify();

    if ($("#park_slug").length > 0) {
        var resource = '/parks/' + $("#park_slug").val() + '.json';
        var lat = $("#park_lat").val();
        var lng = $("#park_long").val();
        buildMap(lat, lng, 15, resource);
    } else {
        buildMap(42.9633, -85.6681, 12, '/parks.json');
    }
    
    function prettify(){
	  for(i=0;i<4;i++){
	    $('aside').append('<span class="concave-corner"></span>')
	  }
	}
});
