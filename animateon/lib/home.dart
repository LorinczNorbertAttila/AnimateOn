import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        title: Text(
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
            SizedBox(
              height: 150,
            ),
            Text(
              'You can start your journey',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'LilitaOne',
              ),
            ),
            Text(
              'by scanning an image:',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'LilitaOne',
              ),
            ),
            SizedBox(
              height: 150,
            ),
            FloatingActionButton.large(
              onPressed: () {
                Navigator.pushNamed(context, '/camera');
              },
              backgroundColor: Colors.amber[300],
              child: Icon(Icons.camera_alt, color: Colors.grey[900], size: 55),
            ),
          ],
        ),
      ),
    );
  }
}
