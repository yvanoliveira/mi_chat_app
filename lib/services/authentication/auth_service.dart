import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Serviço de autenticação que gerencia as operações relacionadas à autenticação
class AuthService extends ChangeNotifier {

  // Instância de autenticação do Firebase
  final FirebaseAuth _authFirebase = FirebaseAuth.instance;

  // Instância do Firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Função para fazer login usando e-mail e senha
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Faz o login
      UserCredential userCredential = await _authFirebase.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );

      // Adiciona um novo documento para o usuário na coleção 'Usuários' se ainda não existir
      _fireStore.collection('Usuários').doc(userCredential.user!.uid).set({
        'UID' : userCredential.user!.uid,
        'E-mail' : email, 
      }, SetOptions(merge: true));

      return userCredential;

    // Captura qualquer erro de autenticação
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Função para criar um novo usuário
  Future<UserCredential> signUpWithEmailandPassaword(
    String email, String password) async {
    try {

      // Cria um novo usuário
      UserCredential userCredential = await _authFirebase.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      // Após criar o usuário, cria um novo documento...
      _fireStore.collection('Usuários').doc(userCredential.user!.uid).set({
        'UID' : userCredential.user!.uid,
        'E-mail' : email, 
      });

      return userCredential;

    // Captura qualquer erro de autenticação
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Função para fazer login com o Google
  signInGoogleAccount() async {
    
    // Inicia o processo interativo de login
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtém detalhes de autenticação da solicitação
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Cria uma nova credencial para o usuário
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken, 
      idToken: gAuth.idToken,
    );
    
    // Faz o login
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Função para fazer logout
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
