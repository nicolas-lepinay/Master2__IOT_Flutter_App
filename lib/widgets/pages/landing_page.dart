import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/typography/h1.dart';
import 'package:arduino_iot_app/widgets/components/textfields/ui_text_field.dart';
import 'package:arduino_iot_app/widgets/components/layout/animated_background.dart';
import 'package:arduino_iot_app/widgets/components/buttons/ui_button.dart';
import 'package:arduino_iot_app/store/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state.user != null) {
        context.go('/home');
      }
    }, builder: (context, state) {
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
                      const H1(text: Constants.landing__title),
                      const SizedBox(height: 40),
                      UITextField(
                        controller: usernameController,
                        hintText: "Nom d'utilisateur",
                      ),
                      const SizedBox(height: 20),
                      UITextField(
                        controller: passwordController,
                        hintText: "Mot de passe",
                        isPassword: true,
                      ),
                      if (state.errorMessage != null)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              state.errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 60),
                      UIButton(
                        label: state.isLoading ? 'Chargement...' : Constants.login,
                        callback: () {
                          //context.push('/home');
                          context.read<LoginCubit>().login(
                                usernameController.text,
                                passwordController.text,
                              );
                        },
                      ),
                      const SizedBox(height: 25),
                      InkWell(
                        onTap: () => context.push('/qrcode-scanner'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code,
                              color: Constants.periwinkle,
                            ),
                            SizedBox(width: 15),
                            Text(
                              Constants.loginWithQrCode,
                              style: TextStyle(
                                color: Constants.periwinkle,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
