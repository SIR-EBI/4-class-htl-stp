import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_list_manager.dart';
import '../default/custom_colors.dart';
import '../domain/domain_list.dart';
import '../widgets/universal/custom_navigation_bar.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<DomainList> domainListList = <DomainList>[];

  void loadListsFromDatabase() async {
    domainListList = await DatabaseListManager.loadListFromDatabase();
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> loadAccountId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String accountId = prefs.getString('accountId') ?? "";
      if (accountId.isEmpty) {
        Navigator.popAndPushNamed(context, '/signInScreen');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadAccountId();

    Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      loadListsFromDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.dark2,
      appBar: AppBar(
        backgroundColor: CustomColor.dark1,
        title: const Text("Shopping lists"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(
                Icons.add,
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/addListScreen');
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
              itemCount: domainListList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: CustomColor.dark3,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListTile(
                        title: Text(
                          domainListList[index].name,
                          style: TextStyle(
                            color: CustomColor.white0,
                            fontWeight: FontWeight.w700,
                            fontSize: 30.0,
                          ),
                        ),
                        subtitle: Text(
                          "${domainListList[index].itemList.length} Items",
                          style: TextStyle(
                            color: CustomColor.white1,
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            DatabaseListManager.deleteList(
                                domainListList[index].id);
                          },
                        ),
                        onTap: () {
                          Navigator.popAndPushNamed(
                            context,
                            '/itemInListScreen',
                            arguments: {
                              "list": domainListList[index],
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
