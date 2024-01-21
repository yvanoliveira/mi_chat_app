import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mi_chat_app/services/chat/message_service.dart';

// Serviço responsável por operações relacionadas a conversas e mensagens
class ChatService extends ChangeNotifier {

  // Instâncias de autenticação e Firestore
  final FirebaseAuth _authFirebase = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Função para enviar uma mensagem
  Future<void> emitMessage(String receiverId, String message) async {

    // Obtém informações do usuário atual
    final String recipientID = _authFirebase.currentUser!.uid;
    final String recipientEmail = _authFirebase.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // Cria uma nova mensagem
    Message newMessage = Message(
      senderId: recipientID, 
      senderEmail: recipientEmail, 
      receiverId: receiverId, 
      timestamp: timestamp, 
      message: message,
    );

    // Constrói o ID da sala de bate-papo a partir do ID do usuário atual e do ID do destinatário (ordenado para garantir a singularidade) 
    List<String> ids = [recipientID, receiverId];
    ids.sort(); // Ordena os IDs (isso garante que o ID da sala de bate-papo seja sempre o mesmo para qualquer grupo de conversa)
    String chatID = ids.join("_"); // Combina os IDs em uma única string para usar como ID da sala de bate-papo

    // Adiciona uma nova mensagem ao banco de dados
    await _fireStore
      .collection('Conversas')
      .doc(chatID)
      .collection('Mensagens')
      .add(newMessage.toMap());
  }

  // Função para obter as mensagens de uma conversa
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {

    // Constrói o ID da sala de bate-papo a partir dos IDs de usuário (ordenado para garantir que corresponda ao ID usado ao enviar mensagens)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatID = ids.join("_");

    return _fireStore
      .collection('Conversas')
      .doc(chatID)
      .collection('Mensagens')
      .orderBy('timestamp', descending: false)
      .snapshots();
  }
}
