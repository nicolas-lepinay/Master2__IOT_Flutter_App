import 'package:flutter/material.dart';

import 'package:arduino_iot_app/widgets/components/animated_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(child: const Center(child: Text("HOME PAGE...")));
  }
}
