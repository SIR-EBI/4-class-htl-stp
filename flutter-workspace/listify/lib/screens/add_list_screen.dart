import 'package:flutter/material.dart';
import 'package:listify_app/database/database_list_manager.dart';

import '../default/custom_colors.dart';
import '../widgets/universal/custom_navigation_bar.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({Key? key}) : super(key: key);

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  TextEditingController listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              controller: listNameController,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: CustomColor.dark3,
                hintText: 'List name',
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
                      DatabaseListManager.createNewList(listNameController.text);
                      Navigator.popAndPushNamed(context, '/listScreen');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Create new List"),
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
