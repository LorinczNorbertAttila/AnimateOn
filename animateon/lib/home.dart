import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _image;
  final imagePicker = ImagePicker();

  Future getImage() async{
   final image = await imagePicker.pickImage(
      source: ImageSource.camera
    );
    if (image == null) return;
    setState(() {
     _image = File(image.path);
    });
  }
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Animate On',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'LilitaOne',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[300],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Text(
              'You can start your journey',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'LilitaOne',
              ),
            ),
            const Text(
              'by scanning an image:',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'LilitaOne',
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            FloatingActionButton.large(
              onPressed: getImage,
              backgroundColor: Colors.amber[300],
              child: Icon(Icons.camera_alt, color: Colors.grey[900], size: 55),
            ),
          ],
        ),
      ),
    );
  }
}

