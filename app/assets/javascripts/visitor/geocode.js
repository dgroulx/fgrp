var geoCoder = new google.maps.Geocoder();

geoCoder.geocode({ address: '38 West Fulton, Grand Rapids, MI' }, function (results, status) {
    if (status === 'OK' && results && results.length > 0) {
        var address = results[0],
            location = address.geometry.location;
        alert(address.formatted_address);
        alert(location.lat());
        alert(location.lng());
    }
});