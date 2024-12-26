import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TambahkanAlamat extends StatefulWidget {
  TambahkanAlamat({super.key});
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-5.4627627, 120.0194028),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  State<TambahkanAlamat> createState() => _TambahkanAlamatState();
}

class _TambahkanAlamatState extends State<TambahkanAlamat> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  final Set<Marker> _marker = {};

  void _addMarker() {
    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId('target_location'),
          position: LatLng(-5.4627627, 120.0194028),
          infoWindow: InfoWindow(
            title: 'My Location',
            snippet: 'This is the marked location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed), // Merah
        ),
      );
    });
  }

  void initState() {
    super.initState();
    _addMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          markers: _marker,
          initialCameraPosition: TambahkanAlamat._kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }




  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(TambahkanAlamat._kLake));
  }
}
