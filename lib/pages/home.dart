import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:mi_chat_app/pages/chat.dart';
import "package:mi_chat_app/services/authentication/auth_service.dart";
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Instância de autenticação
  final FirebaseAuth _authSetting = FirebaseAuth.instance;

  // Função para fazer logout do usuário
  void signOut() {
    
    // Obter o serviço de autenticação usando Provider
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Emoji de círculo verde
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              margin: EdgeInsets.only(right: 8),
            ),
            // Texto "Usuários ativos"
            Text(
              'Usuários ativos',
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          // Botão de logout
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: _UsersList(),
    );
  }

  // Construir a lista de usuários, excluindo o usuário atualmente logado
  Widget _UsersList() {
    return Container(
      color: Colors.black, // Definir a cor de fundo aqui
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Usuários').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Erro');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Carregando...');
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _UserListTopic(doc))
                .toList(),
          );
        },
      ),
    );
  }

  // Construir itens individuais da lista de usuários
  Widget _UserListTopic(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Exibir todos os usuários, exceto o usuário atual
    if (_authSetting.currentUser!.email != data['E-mail']) {
      return ListTile(
        title: Text(
          data['E-mail'],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {

          // Passar o UID do usuário clicado para a página de chat
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                recipientEmail: data['E-mail'],
                recipientID: data['UID'],
              ),
            ),
          );
        },
      );
    } else {
      
      // Retornar um contêiner vazio
      return Container();
    }
  }
}
