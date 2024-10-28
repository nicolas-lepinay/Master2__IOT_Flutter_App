import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginTab extends StatelessWidget {
  const LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Connexion",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            const TextField(
              decoration: InputDecoration(labelText: "Identifiant"),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(labelText: "Mot de passe"),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go('/success'),
              child: const Text("Se connecter"),
            )
          ],
        ),
      ),
    );
  }
}
