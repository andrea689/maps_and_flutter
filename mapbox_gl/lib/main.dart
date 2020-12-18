import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mapbox_gl',
      home: MyHomePage(title: 'mapbox_gl'),
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
  Completer<MapboxMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MapboxMap(
        accessToken: 'YOUR_ACCESS_TOKEN_HERE',
        initialCameraPosition: CameraPosition(
          target: LatLng(41.502461, 13.087058),
          zoom: 4,
        ),
        styleString: 'mapbox://styles/andrea689/ckibuwu4013q519qr3qd1g1vj',
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        onStyleLoadedCallback: () async {
          final MapboxMapController controller = await _controller.future;
          controller.addSymbol(SymbolOptions(
            iconImage: 'embassy-15',
            iconSize: 2,
            geometry: LatLng(37.502461, 15.087058),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateCamera,
        child: Icon(Icons.airplanemode_active),
      ),
    );
  }

  Future<void> _animateCamera() async {
    final MapboxMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(37.502461, 15.087058),
          zoom: 15,
        ),
      ),
    );
  }
}
