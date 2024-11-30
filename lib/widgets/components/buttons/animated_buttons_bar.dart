import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';

class AnimatedButtonsBar extends StatefulWidget {
  // Padding du container parent :
  final double outerPadding;

  // Padding du container gris :
  final double innerPadding;

  // Hauteur d'un bouton :
  final double buttonHeight;

  final List<String> tabNames;
  final List<VoidCallback> onTabSelected;

  const AnimatedButtonsBar({
    super.key,
    this.outerPadding = 30.0,
    this.innerPadding = 15.0,
    this.buttonHeight = 50.0,
    required this.tabNames,
    required this.onTabSelected,
  });

  @override
  _AnimatedButtonsBarState createState() => _AnimatedButtonsBarState();
}

class _AnimatedButtonsBarState extends State<AnimatedButtonsBar> {
  // Index du bouton sélectionné :
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Hauteur du container gris :
    double containerHeight = widget.buttonHeight + (widget.innerPadding * 2);
    // Largeur d'un bouton selon la largeur de l'écran et du nombre de boutons
    final double buttonWidth = (MediaQuery.of(context).size.width -
            (widget.outerPadding * 2) -
            (widget.innerPadding * 2)) /
        3;

    return Container(
      width: double.infinity,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Constants.lightest.withOpacity(0.4),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.innerPadding),
        child: Stack(
          children: [
            // Conteneur violet animé
            AnimatedPositioned(
              left: selectedIndex * buttonWidth,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Container(
                width: buttonWidth,
                height: widget.buttonHeight,
                margin: EdgeInsets.symmetric(vertical: widget.innerPadding),
                decoration: BoxDecoration(
                  color: Constants.lilac,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Constants.lilac.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
            // Boutons de sélection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.tabNames.length,
                (index) {
                  return buildButton(widget.tabNames[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer les boutons
  Widget buildButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          // Exécute l'action spécifique du bouton sélectionné
          widget.onTabSelected[index]();
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14, // Default, 14
              fontWeight: FontWeight.w900,
              color:
                  selectedIndex == index ? Constants.white : Constants.darkest,
            ),
          ),
        ),
      ),
    );
  }
}
