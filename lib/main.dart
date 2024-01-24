import 'package:active_google_map/custom_button.dart';
import 'package:active_google_map/distance_calculator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _locationMessage = "";
  double distance= 0.0;
  double distanceAccepted = 100;
  bool isOkay = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void onButtonPressed(){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You are inside the Location Radius")));
  }

  _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _locationMessage =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        distance = GeoUtils.calculateDistance(position.latitude, position.longitude, 23.754233, 90.399999);
        distance>distanceAccepted ? isOkay = false : isOkay = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                _locationMessage,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Text(distance.toString()),
            distance>distanceAccepted ? Text("Distance too much") : Text("Distance OK"),
            CustomButtonWidget(onTap: (){
              isOkay? onButtonPressed() : null;
            }, title: "Submit", btnColor: isOkay?  Colors.green : Colors.red)
          ],
        ),
      ),
    );
  }
}
