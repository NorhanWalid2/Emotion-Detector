import 'dart:async';

import 'package:emotion_detector/emotion_detector.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const EmotionDetector();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:
          Color.fromARGB(23, 16, 16, 17), // Customize with your preferred color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo or any other branding element goes here
            CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage(
                  'assets/images/Emotionally Intelligent AI Is Coming_ Are You Ready_.jpg'),
            ),

            SizedBox(height: 20),
            Text(
              'Emotional Detector',
              style: TextStyle(
                fontSize: 34,
                color: Color.fromARGB(255, 225, 222, 222),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Powered By Nopav',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 225, 222, 222),
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 100),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your main screen UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Welcome to Emotional Detector App!'),
      ),
    );
  }
}
