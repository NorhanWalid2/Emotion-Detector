import 'package:emotion_detector/emotion_detector.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EmotionDetector();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Emotion Detector',
              style: TextStyle(fontSize: 45, fontStyle: FontStyle.italic),
            ),
          ),
          Text(
            'Powered By Nopav',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          Spacer(
            flex: 1,
          ),
          CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.black,
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
