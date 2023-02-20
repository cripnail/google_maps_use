import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  double _zoom = 11;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: _zoom,
            ),
          ),
          Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.navigate_before), onPressed: _goBack),
                  IconButton(
                      icon: const Icon(Icons.navigate_next), onPressed: _goForward),
                  IconButton(icon: const Icon(Icons.arrow_upward), onPressed: _goUp),
                  IconButton(
                      icon: const Icon(Icons.arrow_downward), onPressed: _goDown),
                  IconButton(icon: const Icon(Icons.home), onPressed: _goHome),
                ],
              )),
          Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Slider(
                  value: _zoom,
                  min: 10,
                  max: 20,
                  onChanged: (value) {
                    _zoom = value;
                    _onZoomChanged(value);
                  }))
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _goBack() {
    mapController!.moveCamera(CameraUpdate.scrollBy(-10, 0));
  }

  void _goForward() {
    mapController!.moveCamera(CameraUpdate.scrollBy(10, 0));
  }

  void _goUp() {
    mapController!.moveCamera(CameraUpdate.scrollBy(0, 10));
  }

  void _goDown() {
    mapController!.moveCamera(CameraUpdate.scrollBy(0, -10));
  }

  void _goHome() {
    mapController!.moveCamera(CameraUpdate.newLatLng(_center));
  }

  void _onZoomChanged(double value) {
    setState(() {
      _zoom = value;
    });
    mapController!.moveCamera(CameraUpdate.newLatLngZoom(_center, _zoom));
  }
}
