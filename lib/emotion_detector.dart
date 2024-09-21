//import 'dart:async';

import 'package:camera/camera.dart';
import 'package:emotion_detector/main.dart';
import 'package:flutter/material.dart';
import 'package:tensorflow_lite_flutter/tensorflow_lite_flutter.dart';

class EmotionDetector extends StatefulWidget {
  const EmotionDetector({super.key});

  @override
  State<EmotionDetector> createState() => _EmotionDetectorState();
}

class _EmotionDetectorState extends State<EmotionDetector> {
  CameraController? cameraController;
  String output = '';
  double conf = 0.0;

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((image) {
            runModel(image);
          });
        });
      }
    });
  }

  runModel(CameraImage img) async {
    dynamic recognitions = await Tflite.runModelOnFrame(
        bytesList: img.planes.map((plane) {
          return plane.bytes;
        }).toList(), // required
        imageHeight: img.height,
        imageWidth: img.width,
        imageMean: 127.5, // defaults to 127.5
        imageStd: 127.5, // defaults to 127.5
        rotation: 90, // defaults to 90, Android only
        numResults: 2, // defaults to 5
        threshold: 0.1, // defaults to 0.1
        asynch: true // defaults to true
        );
    for (var element in recognitions) {
      setState(() {
        output = element['label'];
        conf = element['confidence'] * 1000;
        conf = conf - conf % 1;
        conf /= 10;
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 238, 240),
      appBar: AppBar(
        title: const Text('Emotion Detector'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 400,
              height: 460,
              child: CameraPreview(cameraController!),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  output,
                  style: const TextStyle(fontSize: 35, color: Colors.black),
                ),
              ),
              Center(
                child: Text(
                  conf.toString(),
                  style: const TextStyle(fontSize: 35, color: Colors.black),
                ),
              ),
              const Text(
                '%',
                style: TextStyle(fontSize: 35),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
