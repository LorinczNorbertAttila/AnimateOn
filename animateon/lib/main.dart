import 'camera_app.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() async{
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/camera': (context) => Camera_app()
    },
  ));
}
