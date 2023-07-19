import 'package:flutter/material.dart';
import 'package:animateon/camera.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {'/home': (context) => Home(), '/camera': (context) => Camera()},
  ));
}
