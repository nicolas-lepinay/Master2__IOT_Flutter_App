import 'package:flutter/material.dart';

import 'package:arduino_iot_app/models/equipment.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'animated_card_content.dart';

class AnimatedCard extends StatefulWidget {
  // Position initiale (true pour la position 1, false pour la position 2)
  // final bool initialPosition;

  // Callback pour l'appel d'API au double-tap
  final bool Function() onDoubleTap;
  final Equipment equipment;
  final double ratio;

  const AnimatedCard({
    super.key,
    //required this.initialPosition,
    required this.onDoubleTap,
    required this.equipment,
    this.ratio = 1.2,
  });

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool isPositionOne = true;

  @override
  void initState() {
    super.initState();
    //isPositionOne = widget.initialPosition; // Définir la position initiale
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
    final width = MediaQuery.of(context).size.width - (70 * 2);
    return GestureDetector(
      onDoubleTap: togglePosition,
      child: Center(
        child: Opacity(
          opacity: widget.equipment.state ? 1 : 0.8,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Conteneur violet (arrière-plan)
              Container(
                //width: widget.width,
                //height: widget.width * widget.ratio,
                width: width,
                height: width * widget.ratio,
                decoration: BoxDecoration(
                  //color: Colors.purple.withOpacity(0.3),
                  color: Constants.pickle.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.equipment.state
                          ? Constants.pickle.withOpacity(0.8)
                          : Colors.transparent,
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
              // Conteneur blanc (carte au-dessus)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: AnimatedRotation(
                  turns: widget.equipment.state ? -0.025 : 0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: width,
                    height: width * widget.ratio,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Constants.lightest,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.darkest.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: AnimatedCardContent(
                      equipment: widget.equipment,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
