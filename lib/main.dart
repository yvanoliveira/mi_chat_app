import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mi_chat_app/interface/firebase_api.dart';
import 'package:mi_chat_app/firebase_options.dart';
import 'package:mi_chat_app/pages/notification.dart';
import 'package:mi_chat_app/services/authentication/auth_control.dart';
import 'package:mi_chat_app/services/authentication/auth_service.dart';
import 'package:provider/provider.dart';

// Chave global para o Navigator, útil para navegação em diferentes partes do aplicativo
final KeyNav = GlobalKey<NavigatorState>();

void main() async {

  // Garante que os widgets estejam vinculados corretamente antes de inicializar o Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as opções padrão
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);

  // Inicializa a configuração de notificações do Firebase
  await FirebaseAPI().iniNotifications();

  // Inicializa o aplicativo Flutter.
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyChatApp(),
    ),
  );
}

class MyChatApp extends StatelessWidget {
  const MyChatApp({
    super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      // Desabilita a faixa de debug no canto superior direito
      debugShowCheckedModeBanner: false,

      // Define a tela inicial como AuthRouter, que decide se o usuário está autenticado ou não
      home: AuthControl(),

      // Define a chave do navegador global para a navegação em várias partes do aplicativo
      navigatorKey: KeyNav,

      // Define as rotas nomeadas para navegação
      routes: {
        'lib/pages/notification.dart': (context) => const NotificationPage(),
      },
    );
  }
}
