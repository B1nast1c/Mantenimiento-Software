import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/providers/provider.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';
import './global/globals.dart';

void main() {
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
      home: Home(title: titulo),
    );
  }
}
