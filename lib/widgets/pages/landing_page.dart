import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/heading1.dart';
import 'package:arduino_iot_app/widgets/components/text_body.dart';
import 'package:arduino_iot_app/widgets/components/ui_text_field.dart';
import 'package:arduino_iot_app/widgets/components/animated_background.dart';
import 'package:arduino_iot_app/widgets/components/ui_button.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const HeroSection(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Heading1(text: Constants.landing__title),
                    //const SizedBox(height: 20),
                    //const TextBody(text: Constants.landing__description),
                    const SizedBox(height: 40),
                    UITextField(
                      controller: emailController,
                      hintText: "Adresse e-mail",
                    ),
                    const SizedBox(height: 20),
                    UITextField(
                      controller: passwordController,
                      hintText: "Mot de passe",
                      isPassword: true,
                    ),
                    const SizedBox(height: 60),
                    UIButton(
                      label: "Connexion",
                      callback: () {
                        context.push('/home');
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Constants.lilac,
        image: const DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(Constants.heroImg),
        ),
      ),
    );
  }
}
