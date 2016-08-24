$(document).ready(function(){

  if(document.getElementById("map")) {
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
      var markers = handler.addMarkers([
       { lat: 8, lng: 1},
       { lat: 36, lng: 138},
       { lat: 14, lng: 51},
       { lat: 41, lng: 13},
       { lat: 18, lng: 77},
       { lat: 25, lng: 133},
       { lat: 53, lng: 8},
       { lat: 23, lng: 102},
       { lat: 20, lng: 79},
       { lat: 0, lng: 38},
       { lat: 7, lng: 150},
       { lat: 12, lng: 121},
       { lat: 13, lng: 172},
       { lat: 56, lng: 9},
       { lat: 56, lng: 106}
     ]);
     handler.bounds.extendWith(markers);
     handler.fitMapToBounds();
    });
  }
})
