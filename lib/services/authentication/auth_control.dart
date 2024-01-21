import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:mi_chat_app/pages/home.dart';
import 'package:mi_chat_app/services/authentication/login_control.dart';

// Controle de autenticação para verificar se o usuário está logado ou não
class AuthControl extends StatelessWidget {
  const AuthControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          // Se o usuário estiver logado
          if (snapshot.hasData){
            return const HomeScreen();
          }

          // Se o usuário não estiver logado
          else {
            return const LoginControl();
          }
        },
      ),
    );
  }
}
