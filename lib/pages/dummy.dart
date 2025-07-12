import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

String locationText = 'check';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getCurrentLocation,
              child: Text("Get My Location"),
            ),
            SizedBox(height: 20),
            Text(
              locationText,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      locationText =
          'Latitute: ${position.latitude}\n Longitude: ${position.longitude}';
      openInMap(position.latitude, position.longitude);
      print("runnig");
    } else {
      locationText = "location permission denied";
    }
  }

  Future<void> openInMap(double lat, double lng) async {
    print('method runningopen');
    final googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    //final uri1 = Uri.parse('https://flutter.dev');
    final uri = Uri.parse(googleMapUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('not open');
      throw 'could not open map';
    }
  }
}
