import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide Image;

import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/misc/colour_filter.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // BACKGROUND (SPLINE)
            Positioned(
              bottom: 200,
              left: 100,
              width: MediaQuery.of(context).size.width * 1.7,
              child: Opacity(
                opacity: 0, // Tweak pour changer l'opacité éventuellement
                child: Image.asset(Constants.spline),
              ),
            ),
            // BLUR BACKDROP FILTER (INVISIBLE ???)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20,
                  sigmaY: 10,
                ),
              ),
            ),
            // RIV ANIMATION
            const ColourFilter(
              saturation: 0.1,
              child: RiveAnimation.asset(
                Constants.shapes,
                fit: BoxFit.fitWidth,
              ),
            ),
            // BLUR BACKDROP FILTER
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 50,
                  sigmaY: 50,
                ),
                child:
                    const SizedBox(), // Nécessaire pour que le blur apparaisse
              ),
            ),
            // TEXT
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              height: MediaQuery.of(context).size.height,
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
