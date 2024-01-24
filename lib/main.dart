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
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String _locationMessage = "";
  double distance= 0.0;
  double distanceAccepted = 2.5;
  bool isOkay = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void onButtonPressed(){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You are inside the Location Radius")));
  }

  _getCurrentLocation() async {
    isLoading = true;
    setState(() {});
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _locationMessage =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        distance = GeoUtils.calculateDistance(position.latitude, position.longitude, 23.76127904645549, 90.37178478043978);
        distance>distanceAccepted ? isOkay = false : isOkay = true;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location App"),
      ),
      body: Center(
        child: isLoading? const CircularProgressIndicator() : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                _locationMessage,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Text(distance.toString()),
            distance>distanceAccepted ? const Text("Distance too much") : const Text("Distance OK"),
            CustomButtonWidget(onTap: (){
              isOkay? onButtonPressed() : null;
            }, title: "Submit", btnColor: isOkay?  Colors.green : Colors.red)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_getCurrentLocation();},
        splashColor: Colors.orange,
        foregroundColor: Colors.orange,
        child: const Icon(Icons.location_on_outlined),
      ),
    );
  }
}
