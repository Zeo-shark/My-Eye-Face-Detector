import 'dart:ui' as ui show Image;
import 'dart:math' as Math;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

class FacePaint extends CustomPaint {
  final CustomPainter painter;

  FacePaint({this.painter}) : super(painter: painter);
}

class FacePainterImage extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;

  FacePainterImage(this.image, this.faces);

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      canvas.drawImage(image, Offset.zero, Paint());
    }

    final paintRectStyle = Paint()
      ..color = Colors.red
      ..strokeWidth = 30.0
      ..style = PaintingStyle.stroke;

    

    for (var i = 0; i < faces.length; i++) {
    
      final center = faces[i].boundingBox.center;
      
      canvas.drawRect(faces[i].boundingBox, paintRectStyle);
    }
  }

  @override
  bool shouldRepaint(FacePainterImage oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}

class FacePainterLiveCamera extends CustomPainter {
  final Size imageSize;
  final List<Face> faces;

  FacePainterLiveCamera(this.imageSize, this.faces);

  @override
  void paint(Canvas canvas, Size size) {
   final paintRectStyle = Paint()
     ..color = Colors.red
     ..strokeWidth = 10.0
     ..style = PaintingStyle.stroke;


    for (var i = 0; i < faces.length; i++) {
      //Scale rect to image size
      final rect = _scaleRect(
        rect: faces[i].boundingBox,
        imageSize: imageSize,
        widgetSize: size,
      );

      // Draw rect border
      canvas.drawRect(rect, paintRectStyle);
    }
  }

  @override
  bool shouldRepaint(FacePainterLiveCamera oldDelegate) {
    return imageSize != oldDelegate.imageSize || faces != oldDelegate.faces;
  }
}

Rect _scaleRect({
  @required Rect rect,
  @required Size imageSize,
  @required Size widgetSize,
}) {
  final double scaleX = widgetSize.width / imageSize.width;
  final double scaleY = widgetSize.height / imageSize.height;

  return Rect.fromLTRB(
    rect.left.toDouble() * scaleX,
    rect.top.toDouble() * scaleY,
    rect.right.toDouble() * scaleX,
    rect.bottom.toDouble() * scaleY,
  );
}