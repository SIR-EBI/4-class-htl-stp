import 'package:flutter/material.dart';
import 'package:listify_app/database/database_list_manager.dart';
import 'package:listify_app/domain/domain_list.dart';

import '../default/custom_colors.dart';
import '../widgets/universal/custom_navigation_bar.dart';

class AddUserToListScreen extends StatefulWidget {
  const AddUserToListScreen({Key? key}) : super(key: key);

  @override
  State<AddUserToListScreen> createState() => _AddUserToListScreenState();
}

class _AddUserToListScreenState extends State<AddUserToListScreen> {
  TextEditingController idController = TextEditingController();

  Map data = {};
  late DomainList list;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      data =
      ModalRoute.of(context)!.settings.arguments as Map<String, DomainList>;
      list = data["list"];
    }

    return Scaffold(
      backgroundColor: CustomColor.dark2,
      appBar: AppBar(
        backgroundColor: CustomColor.dark1,
        title: const Text("Shopping lists"),
      ),
      bottomNavigationBar: const CustomNavigationBar(
        index: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: CustomColor.dark3,
                hintText: 'User ID',
                hintStyle: TextStyle(
                  color: CustomColor.white2,
                ),
              ),
              style: TextStyle(
                color: CustomColor.white0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.dark3,
                    ),
                    onPressed: () {
                      DatabaseListManager.addMemberToList(list.id, idController.text.trim());
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Add User"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
