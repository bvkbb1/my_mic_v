import 'package:flutter/material.dart';
import 'package:my_mic_v/my_mic_v.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Mic V Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _recognizedText = 'Tap the microphone to start speaking...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyMic(
          onResult: (text) {
            setState(() {
              _recognizedText = text;
            });
          },
          color: Colors.blue,
          glowColor: Colors.blueAccent,
          size: 60.0,
          listeningDuration: 15,
        ),
      ),
    );
  }
}
