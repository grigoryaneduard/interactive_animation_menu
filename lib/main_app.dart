import 'package:flutter/material.dart';
import 'package:menu_task/src/presentation/pages/pages.dart' show MainPage;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MainPage());
  }
}
