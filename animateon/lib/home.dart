
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'screenTitle.dart';
import 'home_images.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  

  @override
  Widget build(BuildContext context) {

    double height =  MediaQuery.of(context).size.height;

      return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const ScreenTitle(),
            SizedBox(
              height: height *0.04,
            ),
            const Text(
              'You can start your journey\n     by scanning an image:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'LilitaOne',
              ),
            ),
            SizedBox(
              height: height *0.1,
            ),
           
            Align(
              alignment: Alignment.center,
              child: FloatingActionButton(
                  onPressed: (){ Navigator.pushNamed(context, '/match');},
                  backgroundColor: Colors.orange[800],
                  child: const Icon(Icons.camera_alt, color: Colors.black, size: 30),
              ).animate()
                  .scaleXY(duration: const Duration(seconds: 3), end: 1.15, curve: Curves.easeOutBack)
                  .moveY(duration: const Duration(seconds: 3), end: -10)
                  .elevation(duration: const Duration(seconds: 3), end: 24),
            ),
           const HomeImages2(),
          ],
        ),
      );
  }
}

