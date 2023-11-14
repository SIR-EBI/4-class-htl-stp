import 'package:flutter/material.dart';
import 'package:listify_app/screens/add_item_screen.dart';
import 'package:listify_app/screens/add_list_screen.dart';
import 'package:listify_app/screens/add_user_to_list_screen.dart';
import 'package:listify_app/screens/item_in_list_screen.dart';

import 'package:listify_app/screens/list_screen.dart';
import 'package:listify_app/screens/search_screen.dart';
import 'package:listify_app/screens/sign_in_screen.dart';
import 'package:listify_app/screens/sign_up_screen.dart';
import 'package:listify_app/screens/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/listScreen',
      routes: {
        '/signInScreen': (context) => const SignInScreen(),
        '/signUpScreen': (context) => const SignUpScreen(),

        '/listScreen': (context) => const ListScreen(),
        '/searchScreen': (context) => const SearchScreen(),
        '/userScreen': (context) => const UserScreen(),
        '/addItemScreen': (context) => const AddItemScreen(),
        '/addListScreen': (context) => const AddListScreen(),
        '/addUserToListScreen': (context) => const AddUserToListScreen(),
        '/itemInListScreen': (context) => const ItemInListScreen(),
      },
    );
  }
}
