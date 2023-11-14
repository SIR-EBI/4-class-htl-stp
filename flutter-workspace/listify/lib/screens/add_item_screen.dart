import 'package:flutter/material.dart';
import 'package:listify_app/database/database_account_manager.dart';
import 'package:listify_app/domain/domain_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_list_manager.dart';
import '../default/custom_colors.dart';
import '../domain/domain_list.dart';
import '../widgets/universal/custom_navigation_bar.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  Map data = {};
  late DomainItem item;

  TextEditingController amountController = TextEditingController();

  List<DomainList> domainListList = <DomainList>[];

  void loadListsFromDatabase() async {
    domainListList = await DatabaseListManager.loadListFromDatabase();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      data =
          ModalRoute.of(context)!.settings.arguments as Map<String, DomainItem>;
      item = data["item"];
    }
    if (domainListList.isEmpty) {
      loadListsFromDatabase();
    }

    return Scaffold(
      backgroundColor: CustomColor.dark2,
      appBar: AppBar(
        backgroundColor: CustomColor.dark1,
        title: const Text("Add Item to List"),
      ),
      bottomNavigationBar: const CustomNavigationBar(
        index: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: domainListList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: CustomColor.dark3,
                  ),
                  child: ListTile(
                    title: Text(
                      domainListList[index].name,
                      style: TextStyle(
                        color: CustomColor.white1,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      String accountId = prefs.getString('accountId') ?? "";
                      DatabaseAccountManager.addItemToAccount(item.name, accountId);

                      DatabaseListManager.addItemToList(domainListList[index], item, amountController.text);
                      Navigator.popAndPushNamed(context, '/searchScreen');
                    },
                  ),
                ),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: amountController,
              maxLength: 26,
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: CustomColor.white2,
              decoration: InputDecoration(
                filled: true,
                fillColor: CustomColor.dark3,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
                hintText: "Item amount",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: CustomColor.white2,
                ),
              ),
              style: TextStyle(
                fontSize: 20.0,
                color: CustomColor.white0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
