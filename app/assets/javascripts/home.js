OpenLayer = {
  locations: null,
  vectorSource: null,

  init: function(locations){
    OpenLayer.locations = locations;
    OpenLayer.vectorSource = new ol.source.Vector();
    var vectorLayer = new ol.layer.Vector({
      source: this.vectorSource,
      style: this.markerStyle
    });

    var layer = new ol.layer.Tile({
      source: new ol.source.OSM()
    });

    var center = ol.proj.fromLonLat([0, 0]);

    var view = new ol.View({
      center: center,
      zoom: 2
    });

    var map = new ol.Map({
      target: 'map',
      layers: [layer, vectorLayer],
      view: view
    });

    OpenLayer.drawMarker();

    var select = new ol.interaction.Select({
      layers: [vectorLayer]
    });

    var selectedFeatures = select.getFeatures();
    selectedFeatures.on('add', function(event) {
      var feature = event.target.item(0).U;
      $("#location_id").val(feature.id);
      $("#location_latitude").val(feature.latitude);
      $("#location_longitude").val(feature.longitude);
    });

    map.addInteraction(select);
    map.on("click", function(evt){
      $("#location_id").val("")
      var coord = ol.proj.transform(evt.coordinate, 'EPSG:3857', 'EPSG:4326');
      var stringifyFunc = ol.coordinate.createStringXY(2);
      var longLat = stringifyFunc(coord).split(", ");
      setTimeout(function(){
        if(!$("#location_id").val()) {
          $("#location_latitude").val(longLat[1]);
          $("#location_longitude").val(longLat[0]);
        }
      }, 500);
    });
  },

  drawMarker: function(){
    var transform = ol.proj.getTransform('EPSG:4326', 'EPSG:3857');
    OpenLayer.locations.forEach(function(location){
      var feature = new ol.Feature(location);
      var coordinate = transform([parseFloat(location.longitude), parseFloat(location.latitude)]);
      var geometry = new ol.geom.Point(coordinate);

      feature.setGeometry(geometry);
      // add the feature to the source
      OpenLayer.vectorSource.addFeature(feature);

    });
  },

  markerStyle: function(feature) {
    var markerColor = feature.U.public ? 'green' : 'red';
    var style = new ol.style.Style({
      image: new ol.style.Circle({
        radius: 6,
        stroke: new ol.style.Stroke({
          color: 'white',
          width: 2
        }),
        fill: new ol.style.Fill({
          color: markerColor
        })
      })
    });
    return [style];
  }
};
