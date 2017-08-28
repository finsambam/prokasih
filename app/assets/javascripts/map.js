var ready = function() {
  var lat_field, lng_field, markers, placeMarkerAndPanTo, updateFields;
  var mapUrl = 'http://maps.googleapis.com/maps/api/js?v=3&key=AIzaSyCOAyYfIrUNFcKuJ9yEJYjAQYxyNMB3xS0&libraries=places&callback=initialize';
  markers = [];
  lat_field = $('#location_latitude');
  lng_field = $('#location_longitude');

  // check if google map script are exist
  isLoadedScript = function(lib) {
    return document.querySelectorAll('[src="' + lib + '"]').length > 0
  };

  // load google map script 
  loadScript = function(src,callback){
    var script = document.createElement("script");
    script.type = "text/javascript";
    if(callback)script.onload=callback;
    document.getElementsByTagName("head")[0].appendChild(script);
    script.src = src;
  };

  // initialize map
  initialize = function() {
    var map;
    var latLng = new google.maps.LatLng(-6.8797, 109.126);     
    var zoom = 10;
    log('maps-API has been loaded, ready to use');

    if (lat_field.val() != "" && lng_field.val() != "") {
      zoom = 15;
      latLng = new google.maps.LatLng(lat_field.val(), lng_field.val());  
    };

    var mapOptions = {
      zoom: zoom,
      center: latLng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById('map'),
      mapOptions);

    map.addListener('click', function(e) {
      placeMarkerAndPanTo(e.latLng, map);
      return updateFields(e.latLng);
    });

    // Create the search box and link it to the UI element.
    var input = document.getElementById('address-field');
    var searchBox = new google.maps.places.SearchBox(input);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
      searchBox.setBounds(map.getBounds());
    });

    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBox.addListener('places_changed', function() {
      var places = searchBox.getPlaces();

      if (places.length == 0) {
        return;
      }

      // Clear out the old markers.
      markers.forEach(function(marker) {
        marker.setMap(null);
      });
      markers = [];

      // For each place, get the icon, name and location.
      var bounds = new google.maps.LatLngBounds();
      places.forEach(function(place) {
        if (!place.geometry) {
          console.log("Returned place contains no geometry");
          return;
        }
        var icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };

        // Create a marker for each place.
        markers.push(new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));

        if (place.geometry.viewport) {
          // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
        }

        // Write latitude/longitude to field
        lat_field.val(place.geometry.location.lat());
        lng_field.val(place.geometry.location.lng());
      
      });
      map.fitBounds(bounds);
    });

    if (lat_field.val() != "" && lng_field.val() != "") {
      placeMarkerAndPanTo({lat: Number(lat_field.val()), lng: Number(lng_field.val())}, map);
    };
  };

  log = function(str){
    console.log('['+new Date().getTime()+']\n'+str+'\n\n');
  };
  
  placeMarkerAndPanTo = function(latLng, map) {
    var marker;
    while (markers.length) {
      markers.pop().setMap(null);
    }
    marker = new google.maps.Marker({
      position: latLng,
      map: map
    });
    map.panTo(latLng);
    return markers.push(marker);
  };

  if (!isLoadedScript(mapUrl)) {
    loadScript(mapUrl,
              function(){log('google-loader has been loaded, but not the maps-API ');});
  }

  return updateFields = function(latLng) {
    lat_field.val(latLng.lat());
    return lng_field.val(latLng.lng());
  };
};

$(document).ready(ready);