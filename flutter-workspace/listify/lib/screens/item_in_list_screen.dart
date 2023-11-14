import 'package:flutter/material.dart';
import 'package:listify_app/database/database_list_manager.dart';
import 'package:listify_app/domain/domain_list.dart';

import '../default/custom_colors.dart';
import '../widgets/universal/custom_navigation_bar.dart';

class ItemInListScreen extends StatefulWidget {
  const ItemInListScreen({Key? key}) : super(key: key);

  @override
  State<ItemInListScreen> createState() => _ItemInListScreenState();
}

class _ItemInListScreenState extends State<ItemInListScreen> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/listScreen');
          },
        ),
        backgroundColor: CustomColor.dark1,
        title: Text(list.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(
                Icons.supervisor_account_rounded,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/addUserToListScreen',
                    arguments: {
                      "list": list,
                    });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(
        index: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: list.itemList.length,
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
                        list.itemList[index].name,
                        style: TextStyle(
                          color: CustomColor.white1,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                      subtitle: Text(
                        list.itemList[index].amount,
                        style: TextStyle(
                          color: CustomColor.white1,
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        color: CustomColor.white0,
                        onPressed: () {
                          DatabaseListManager.removeItemFromList(list.id, list.itemList[index].id);
                          list.itemList.remove(list.itemList[index]);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
