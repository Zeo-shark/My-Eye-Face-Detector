import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Eye',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: HomeScreen(),
    );
  }
}



