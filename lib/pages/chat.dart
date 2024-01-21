import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mi_chat_app/components/chat_box.dart';
import 'package:mi_chat_app/components/message_field.dart';
import 'package:mi_chat_app/services/chat/chat_service.dart';


// Representa a tela de bate-papo entre usuários
class ChatScreen extends StatefulWidget {

  // Identificador do usuário que receberá a mensagem
  final String recipientEmail;
  final String recipientID;
  const ChatScreen({
    super.key,
    required this.recipientEmail,
    required this.recipientID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textMessageController = TextEditingController(); // Controlador para o campo de entrada de texto
  final ChatService _chatService = ChatService(); // Instância do serviço de chat personalizado
  final FirebaseAuth _authFirebase = FirebaseAuth.instance; // Instância do serviço de autenticação do Firebase

  void emitMessage() async {
    if (
      _textMessageController.text.isNotEmpty) { // Envia uma mensagem não nula
      await _chatService.emitMessage(
          widget.recipientID, _textMessageController.text);

      // Limpa o controlador de texto após o envio da mensagem
      _textMessageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipientEmail)),
      body: Column(
        children: [

          // Lista de mensagens
          Expanded(
            child: _MessageList(),
            
          ),

          // Entrada do usuário para enviar mensagens
          _MessageInput(),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // Método para construir a lista de mensagens
      Widget _MessageList() {
        return Container(
          color: Colors.white, // Adiciona um background ao fundo da lista de mensagens
          child: StreamBuilder<QuerySnapshot>(
            stream: _chatService.getMessages(
              widget.recipientID, 
              _authFirebase.currentUser!.uid),
            builder: (context, snapshot) {
              print(snapshot.data);

              if (snapshot.hasError) {
                return Text('Erro! ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Carregando...');
              }

              // Agora, snapshot.data é um QuerySnapshot diretamente
              return ListView(
                children: snapshot.data!.docs
                    .map((document) => _MessageTopic(document))
                    .toList(),
              );
            },
          ),
        );
      }

    // Método para construir um item de mensagem
    Widget _MessageTopic(DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Alinha as mensagens à direita se o remetente for o usuário atual, caso contrário, à esquerda
    var alignment = (data['senderID'] == _authFirebase.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: 
          (data['senderID'] == _authFirebase.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: 
          (data['senderID'] == _authFirebase.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 3),
            ChatBox(message: data['message']),
          ],
        ),
      ),
    );
  }

  // Método para construir a entrada de mensagem
  Widget _MessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // Campo de texto 
          Expanded(
            child: MyMessageField(
              controller: _textMessageController,
              hintText: 'Mensagem',
              obscureText: false,
            ),
          ),

          // Botão de enviar
          IconButton(
            onPressed: emitMessage,
            icon: const Icon(
              Icons.send,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}
