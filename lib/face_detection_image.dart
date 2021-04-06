import 'package:flutter/material.dart';
import 'dart:io';
import 'face_painter.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:ui' as ui show Image;
import 'package:image_picker/image_picker.dart';

class FaceDetectionFromImage extends StatefulWidget {
  @override
  _FaceDetectionFromImageState createState() => _FaceDetectionFromImageState();
}

class _FaceDetectionFromImageState extends State<FaceDetectionFromImage> {
  bool loading = true;
  ui.Image image;
  List<Face> faces;
  final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

  void pickAndProcessImage() async {
    final PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50);
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(File(file.path));
    faces = await faceDetector.processImage(visionImage);
    image = await _loadImage(File(file.path));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face detection on Image'),
      ),
      body: Center(
        child: loading
            ? Text('Press The floating Action Button for load image!')
            : FittedBox(
                child: SizedBox(
                  width: image.width.toDouble(),
                  height: image.height.toDouble(),
                  child: FacePaint(
                    painter: FacePainterImage(image, faces),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickAndProcessImage,
        child: Icon(Icons.image),
      ),
    );
  }
}