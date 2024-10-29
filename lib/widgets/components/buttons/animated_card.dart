import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class AnimatedCard extends StatefulWidget {
  // Position initiale (true pour la position 1, false pour la position 2)
  final bool initialPosition;

  // Callback pour l'appel d'API au double-tap
  final bool Function() onDoubleTap;

  final double width;
  final double ratio;
  final Widget body;

  const AnimatedCard({
    super.key,
    required this.initialPosition,
    required this.onDoubleTap,
    required this.width,
    required this.ratio,
    required this.body,
  });

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool isPositionOne = true;

  @override
  void initState() {
    super.initState();
    isPositionOne = widget.initialPosition; // Définir la position initiale
  }

  void togglePosition() {
    // Appel d'API déclenché par le double-tap et mise à jour de l'animation
    final newPosition = widget.onDoubleTap();
    setState(() {
      isPositionOne = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: togglePosition,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Conteneur violet (arrière-plan)
            Container(
              width: widget.width,
              height: widget.width * widget.ratio,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            // Conteneur blanc (carte au-dessus)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              top: isPositionOne ? 0 : 0,
              left: isPositionOne ? 0 : 0,
              child: AnimatedRotation(
                turns: isPositionOne ? -0.025 : 0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Container(
                  width: widget.width,
                  height: widget.width * widget.ratio,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Constants.offWhite,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: widget.body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
