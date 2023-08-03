import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/realtime/live_camera.dart';
import 'package:object_detection/static%20image/static.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // running the app
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  aboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: "Paano Kaon Object Detection Prototype",
      applicationLegalese: "By Rupak Karki and built on by KV laurea",
      applicationVersion: "1.1",
      children: <Widget>[
        Text("In Alpha Development"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: aboutDialog,
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 170,
                child: ElevatedButton(
                  child: Text("Detect in Image"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaticImage(),
                      ),
                    );
                  },
                ),
              ),
              
              ButtonTheme(
                minWidth: 160,
                child: ElevatedButton(
                  child: Text("Real Time Detection"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveFeed(cameras),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
