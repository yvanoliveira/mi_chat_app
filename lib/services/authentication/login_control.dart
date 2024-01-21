import 'package:flutter/material.dart';
import 'package:mi_chat_app/pages/login.dart';
import 'package:mi_chat_app/pages/register.dart';

// Controle para alternar entre a tela de login e registro
class LoginControl extends StatefulWidget {
  const LoginControl({super.key});

  @override
  State<LoginControl> createState() => _LoginControlState();
}

class _LoginControlState extends State<LoginControl> {

  // Flag para determinar que a tela de login ou registro deve ser exibida inicialmente
  bool showLoginScreen = true;

  // Alternar entre as páginas de login e registro
  void togglePages() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {

    // Condição para determinar qual tela exibir com base na flag showLoginScreen
    if (showLoginScreen) {

      // Se showLoginScreen for verdadeiro, exibe a tela de login
      return LoginScreen(onTap: togglePages);
    } else {
      
      // Se showLoginScreen for falso, exibe a tela de registro
      return RegisterScreen(onTap: togglePages);
    }
  }
}
