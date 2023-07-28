
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'camera_screen.dart';
import 'home.dart';

void main() async{
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => const Home(),
    },
     onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/camera':
        return PageTransition(
          child: const CameraScreen(), 
          type: PageTransitionType.scale, 
          alignment: Alignment.center, 
          duration: const Duration(milliseconds: 800));
      default:
        return null;
    }
  },
  ));
  await Firebase.initializeApp();
}
