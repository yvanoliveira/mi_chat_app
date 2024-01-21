import 'package:flutter/material.dart';

// Widget que representa uma caixa de mensagem em um chat
class ChatBox extends StatelessWidget {
  final String message;  // O conteúdo da mensagem a ser exibida na caixa

  // Construtor da classe
  const ChatBox({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[400],
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
      ),
    );
  }
}
