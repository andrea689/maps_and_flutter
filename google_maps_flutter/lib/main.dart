import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'google_maps_flutter',
      home: MyHomePage(title: 'google_maps_flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(41.502461, 13.087058),
          zoom: 5,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId('markerId'),
            position: LatLng(37.502461, 15.087058),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateCamera,
        child: Icon(Icons.airplanemode_active),
      ),
    );
  }

  Future<void> _animateCamera() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(37.502461, 15.087058),
          zoom: 16,
        ),
      ),
    );
  }
}
