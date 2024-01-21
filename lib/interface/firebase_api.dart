import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mi_chat_app/main.dart';

// Classe responsável por interações com o Firebase Cloud Messaging (FCM)
class FirebaseAPI {

  // Cria uma instância do Firebase Messaging
  final _messagingFirebase = FirebaseMessaging.instance;

  // Função para inicializar as notificações
  Future<void> iniNotifications() async {

    // Solicita permissão ao usuário (irá solicitar permissão ao usuário)
    await _messagingFirebase.requestPermission();

    // Obtém o token FCM para este dispositivo
    final fCMToken = await _messagingFirebase.getToken();

  
    // Imprime o token (normalmente, você enviaria isso para seu servidor)
    print('Token: $fCMToken');

     // Inicializa configurações adicionais para notificações push
    iniPusNotifications();

  }
   
  // Função para lidar com mensagens recebidas
  
  void handleMessage(RemoteMessage? message) {
    // Se a mensagem for nula, não faz nada
    if (message == null) return;

    // Navega para uma nova tela quando a mensagem é recebida e o usuário toca na notificação
    KeyNav.currentState?.pushNamed(
      '/lib/pages/notification.dart',
      arguments: message,
    );
  }

// Função para inicializar configurações de notificações push em segundo plano
 Future iniPusNotifications() async {
  
  // Manipula a notificação se o aplicativo foi encerrado e agora está sendo aberto
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

  // Anexa ouvintes de eventos para quando uma notificação abrir o aplicativo
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

 }
}