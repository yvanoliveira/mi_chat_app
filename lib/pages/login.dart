import 'package:flutter/material.dart';
import 'package:mi_chat_app/components/button.dart';
import 'package:mi_chat_app/components/message_field.dart';
import 'package:mi_chat_app/services/authentication/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:mi_chat_app/components/box_google.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Controladores de texto
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  // Função para fazer login do usuário
  void signIn() async {

    // Obtém o serviço de autenticação usando Provider
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        emailControl.text,
        passwordControl.text,
      );
    } catch (e) {
      // Exibe uma mensagem de erro usando uma SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Logo
                Icon(
                  Icons.chat,
                  size: 100,
                  color: Colors.grey[200],
                ),

                const SizedBox(height: 50),

                // Mensagem de boas-vindas
                const Text(
                  "Bem-vindo ao Chat App!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                // Campo de texto para e-mail
                MyMessageField(
                  controller: emailControl,
                  hintText: 'E-mail',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Campo de texto para senha
                MyMessageField(
                  controller: passwordControl,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // Botão de login
                MyButton(onTap: signIn, text: 'Entrar'),

                const SizedBox(height: 50),

                // Ou continue com o Google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Ou entre com o Google',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Botão de login com o Google
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    // Botão do Google
                    BoxGoogle(
                        onTap: () => AuthService().signInGoogleAccount(),
                        imagePath: 'lib/images/google.png'
                    ),

                    SizedBox(width: 5),
                  ],
                ),

                const SizedBox(height: 40),

                // Não é membro? Registre-se agora
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Não é cadastrado?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Cadastre-se agora',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
