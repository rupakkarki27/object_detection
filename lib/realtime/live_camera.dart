import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/realtime/bounding_box.dart';
import 'package:object_detection/realtime/camera.dart';
import 'dart:math' as math;
// import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:tflite/tflite.dart';

class LiveFeed extends StatefulWidget {
  LiveFeed(this.cameras);

  final List<CameraDescription> cameras;

  @override
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  int _imageHeight = 0;
  int _imageWidth = 0;
  List<dynamic>? _recognitions;

  @override
  void initState() { 
    super.initState();
    loadTfModel();
  }

  initCameras() async {

  }

  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/models/custom_model.tflite",
      labels: "assets/models/custom_label.txt",
    );
  }

  /* 
  The set recognitions function assigns the values of recognitions, imageHeight and width to the variables defined here as callback
  */
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Time Object Detection"),
      ),
      body: Stack(
        children: <Widget>[
          CameraFeed(widget.cameras, setRecognitions),
          BoundingBox(
            _recognitions == null ? [] : _recognitions!,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
          ),
        ],
      ),
    );
  }
}