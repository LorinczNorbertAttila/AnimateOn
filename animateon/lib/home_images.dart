import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeImages extends StatefulWidget {
  const HomeImages({super.key});

  @override
  State<HomeImages> createState() => _ImagesState();
}

class _ImagesState extends State<HomeImages> with TickerProviderStateMixin {

  late AnimationController controller;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this
    );
    timer = Timer.periodic(const Duration(seconds: 3), (timer){
        final isLastIndex = index == widgets.length - 1;
        setState(() => index = isLastIndex ? 0 : index+1);
    });
  }
  Timer? timer;
  int index = 0;

  final widgets = [
    Image.asset('images/arrangementingrayandblack.jpg', fit: BoxFit.cover, key: Key('1'),),
    Image.asset('images/asundayafternoon.jpg',fit: BoxFit.cover, key: Key('2'),),
    Image.asset('images/girlwithapearl.jpg', fit: BoxFit.cover, key: Key('3'),),
    Image.asset('images/les demoislles.jpg', fit: BoxFit.cover, key: Key('4'),),
    Image.asset('images/monalisa.jpg', fit: BoxFit.cover, key: Key('5'),),
    Image.asset('images/sandrobotticelli.jpg', fit: BoxFit.cover, key: Key('6'),),
    Image.asset('images/thearnolfiniportrait.jpg', fit: BoxFit.cover, key: Key('7'),),
    Image.asset('images/thegardenofearthlyelights.jpg', fit: BoxFit.cover, key: Key('8'),),
    Image.asset('images/thekiss.jpg', fit: BoxFit.cover, key: Key('9'),),
    Image.asset('images/thesatrrynight.jpg', fit: BoxFit.cover, key: Key('10'),),
    Image.asset('images/thescream.jpg', fit: BoxFit.cover, key: Key('11'),),
    
  ];

  @override
  void dispose() {
    super.dispose();
  timer?.cancel();
  dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child,),
      child: widgets[index]
    );
  }
}

class HomeImages2 extends StatefulWidget {
  const HomeImages2({super.key});

  @override
  State<HomeImages2> createState() => _HomeImages2State();
}

class _HomeImages2State extends State<HomeImages2> {
  @override
  Widget build(BuildContext context) {
    return const Image(
              image: AssetImage('images/2.png')
           ).animate()
              .fadeIn(duration: const Duration(seconds: 2), curve: Curves.easeOutCirc)
              .blurXY(duration: const Duration(milliseconds: 1200), begin: 16)
              .scaleXY(duration: const Duration(seconds: 2), begin: 1.5);
  }
}



