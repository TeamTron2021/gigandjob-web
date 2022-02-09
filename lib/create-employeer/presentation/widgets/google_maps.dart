import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;

Widget getMap() {
  String htmlId = "7";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final myLatlng = LatLng(1.3521, 103.8198);

    final mapOptions = MapOptions()
      ..zoom = 10
      ..center = LatLng(1.3521, 103.8198);

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = GMap(elem, mapOptions);

    final marker  = Marker(MarkerOptions()
      ..position = myLatlng
      ..map = map
      ..title = 'Hello World!'
      ..icon = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png'
    );

    final infoWindow = InfoWindow(InfoWindowOptions()..content = '');
    marker.onClick.listen((event) => infoWindow.open(map, marker));

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}