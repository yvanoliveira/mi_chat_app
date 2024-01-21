import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Obtém a mensagem de notificação e exiba na tela
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(title: Text("Notificação")),
      body: Column(
        children: [
          
          // Título da notificação
          Text(message.notification!.title.toString()),

          // Corpo da notificação
          Text(message.notification!.body.toString()),

          // Dados adicionais da notificação
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
