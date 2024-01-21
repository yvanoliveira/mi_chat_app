import 'package:flutter/material.dart';
import 'package:mi_chat_app/components/button.dart';
import 'package:mi_chat_app/components/box_google.dart';
import 'package:mi_chat_app/components/message_field.dart';
import 'package:mi_chat_app/services/authentication/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;
  const RegisterScreen({
    super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // Controladores de texto
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final confirmPasswordControl = TextEditingController();

  // Função para registrar o usuário
  void signUp() async {
    if (passwordControl.text != confirmPasswordControl.text) {

      // Senhas não coincidem, exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senhas não coincidem!'),
        ),
      );
      return;
    }

    // Obtém o serviço de autenticação usando Provider
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassaword(
        emailControl.text,
        passwordControl.text,
      );
    } catch (e) {

      // Exibe uma mensagem de erro usando uma SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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
                  Icons.message,
                  size: 100,
                  color: Colors.white,
                ),

                const SizedBox(height: 50),

                // Mensagem para criar uma conta
                const Text(
                  "Vamos criar uma conta para você!",
                  style: TextStyle(
                    fontSize: 16,
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

                const SizedBox(height: 10),

                // Campo de texto para confirmar senha
                MyMessageField(
                  controller: confirmPasswordControl,
                  hintText: 'Confirme sua senha',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // Botão de cadastro
                MyButton(onTap: signUp, text: 'Cadastrar'),

                const SizedBox(height: 40),

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

                const SizedBox(height: 20),

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

                const SizedBox(height: 20),

                // Já é cadastrado? Entre agora
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já é cadastrado?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Entre agora',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
