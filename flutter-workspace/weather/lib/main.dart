import 'package:flutter/material.dart';
import 'package:flutter_test_eberhardt/sides/home.dart';
import 'package:flutter_test_eberhardt/sides/setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => const Home(),
        "/setting" : (context) => const Setting(),
      },
    );
  }
}

