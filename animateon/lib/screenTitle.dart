import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Icon(
              Icons.photo_size_select_actual_outlined,
              size: 40,
              color: Colors.orange[800],
            ),
            const Text(
            'Animate On',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'LilitaOne',
              color: Colors.black
            ),
            ),
          ],
      ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.ms)
        .animate() // this wraps the previous Animate in another Animate
        .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
        .slide();
  }
}
