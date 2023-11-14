import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_account_manager.dart';
import '../default/custom_colors.dart';
import '../domain/domain_account.dart';
import '../widgets/universal/custom_navigation_bar.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  String name = "";
  String email = "";
  String id = "";

  @override
  void initState() {
    super.initState();

    loadAccountData();

  }

  Future<void> loadAccountData() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('accountId') ?? "";

    DomainAccount? account = await DatabaseAccountManager.getDataOfAccountID(id);

    if (account != null) {
      email = account.email;
      setState(() {});
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.popAndPushNamed(context, '/signInScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.dark2,
      appBar: AppBar(
        backgroundColor: CustomColor.dark1,
        title: const Text("Account"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(
                Icons.logout,
              ),
              onTap: () {
                logout();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(
        index: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 200.0,
                  color: CustomColor.white0,
                ),
                Text(
                  "Id: $id",
                  style: TextStyle(
                    color: CustomColor.white0,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  "Email: $email",
                  style: TextStyle(
                    color: CustomColor.white0,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}
