import 'package:flutter/material.dart';
import 'face_detection_camera.dart';
import 'face_detection_image.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              children: <Widget>[
                Icon(Icons.remove_red_eye_outlined, color: Colors.green),
                Text("My Eye")
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        text:
                            "Select an Input form to implement face Detection",
                        style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            color: Colors.green,
                            fontSize: 25,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: 120),
                RaisedButton(
                    child: Text('Add an image from your Gallery'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FaceDetectionFromImage(),
                        ),
                      );
                    }),
                SizedBox(height: 20),
                RaisedButton(
                    child: Text("Add Camera Video feed to detect faces"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FaceDetectionFromLiveCamera(),
                        ),
                      );
                    }),
              ]),
        ));
  }
}






