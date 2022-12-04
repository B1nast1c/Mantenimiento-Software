import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/providers/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';
import './global/globals.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  //Notificaciones
  WidgetsFlutterBinding.ensureInitialized();
  AndroidInitializationSettings settings =
      const AndroidInitializationSettings('notification');
  InitializationSettings initSettings =
      InitializationSettings(android: settings);

  bool? init = await notificationsPlugin.initialize(
      initSettings); //Check si se ha inicializado correctamente el plugin de notificaciones

  runApp(ChangeNotifierProvider<Changes>(
    child: const MyApp(),
    create: (_) => Changes(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: const loadingScreen(),
    );
  }
}

// ignore: camel_case_types
class loadingScreen extends StatelessWidget {
  const loadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Lottie.asset('assets/loading.json'),
        nextScreen: Home(title: titulo),
        splashIconSize: 440,
        duration: 3500,
        splashTransition: SplashTransition.fadeTransition);
  }
}
