import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BikeRackLocator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bike Rack Locator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var client = DefaultApi();
  List<Location> _locations = List.empty(growable: true);
  List<String> _descriptions = List.empty(growable: true);
  List<Marker> markers = List.empty(growable: true);


  Future _getLocations() async {
    _locations = await client.locationsGet();
    for (var location in _locations) {
      _descriptions.add(location.description);
    }
  }

  void _addLocation() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _LocationAddScreen()),
      );
    });
  }

  void _genMarkers() {
    for (Location location in _locations) {
      markers.add(Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(location.latitude as double, location.longitude as double),
        builder: (ctx) =>
            Container(
              child: const Icon(
                Icons.location_on
              ),
            ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _getLocations().then((value) => _genMarkers());
    sleep(const Duration(seconds: 5));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(0, 0),
          zoom: 13.0,
        ),
        layers: [
          MarkerLayerOptions(
            markers: markers
          ),
        ],
        children: <Widget>[
          TileLayerWidget(options: TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']
          )),
          LocationMarkerLayerWidget(
            plugin: const LocationMarkerPlugin(
              centerOnLocationUpdate: CenterOnLocationUpdate.first,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLocation,
        tooltip: 'Add Location',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _LocationAddScreen extends StatelessWidget {
  // This widget is the root of your application.
  Future<bool> _onBackPressed() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Center(
          child: _LocationAddPage(title: 'Add Location'),
        ),
      ),
    );
  }
}
class _LocationAddPage extends StatefulWidget {
  _LocationAddPage({required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LocationAddState createState() => _LocationAddState();
}

class _LocationAddState extends State<_LocationAddPage> {

  XFile? photo;
  final ImagePicker _picker = ImagePicker();
  String description = "";
  Future capturePhoto() async{
    photo = await _picker.pickImage(source: ImageSource.camera);
  }
  Future submit() async {
    if (description.isEmpty) {
      return showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Field Empty!"),
          content: const Text("Please provide a description!"),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    }
    if (photo == null) {
      return showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No photo!"),
          content: const Text("Please provide a photo!"),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final photoBytes = File(photo!.path).readAsBytesSync();
    String photo64 = base64Encode(photoBytes);
    Location location = Location(latitude: position.latitude, longitude: position.longitude, photo: photo64, description: description);
    DefaultApi api = DefaultApi();
    await api.addlocationPost(location);
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Submitted!"),
        content: const Text("Your entry was submitted to the admin team for approval."),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
  void _updateDesc(String desc) {
    description = desc;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),

      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your current location will be sent as the bike rack location.',
            ),
            TextField(
              onSubmitted: _updateDesc,
            ),
            IconButton(onPressed: capturePhoto, icon: const Icon(Icons.camera)),
            IconButton(onPressed: submit, icon: const Icon(Icons.send))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
