import 'dart:math';

import 'package:flutter/material.dart';
import 'package:listify_app/domain/domain_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_item_manager.dart';
import '../default/custom_colors.dart';
import '../widgets/universal/custom_navigation_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<DomainItem> domainItemList = <DomainItem>[];
  List<DomainItem> showDomainItemList = <DomainItem>[];

  TextEditingController searchController = TextEditingController();

  void loadItemsFromDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    String accountId = prefs.getString('accountId') ?? "";

    domainItemList = await DatabaseItemManager.loadItemsFromDatabase(accountId);
    showDomainItemList = [...domainItemList];
    setState(() {});
  }

  void updateShowDomainItemList() {
    List<DomainItem> newList = <DomainItem>[];
    String searchString = searchController.text.trim();

    for (var element in domainItemList) {
      if (element.name.toLowerCase().contains(searchString.toLowerCase())) {
        newList.add(element);
      }
    }
    showDomainItemList = [...newList];
    if (searchString.isNotEmpty) {
      var r = Random();
      showDomainItemList.insert(0, DomainItem(String.fromCharCodes(List.generate(30, (index) => r.nextInt(33) + 89)), searchString));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (domainItemList.isEmpty) {
      loadItemsFromDatabase();
    }

    return Scaffold(
      backgroundColor: CustomColor.dark2,
      appBar: AppBar(
        backgroundColor: CustomColor.dark1,
        title: const Text("Search"),
      ),
      bottomNavigationBar: const CustomNavigationBar(
        index: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // show search items
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: showDomainItemList.length,
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
                        showDomainItemList[index].name,
                        style: TextStyle(
                          color: searchController.text.trim().isNotEmpty && index == 0 ? CustomColor.white2 : CustomColor.white0,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(
                          context,
                          '/addItemScreen',
                          arguments: {
                            "item": showDomainItemList[index],
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: searchController,
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
                hintText: "Item name",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: CustomColor.white2,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: CustomColor.white1,
                ),
              ),
              style: TextStyle(
                fontSize: 20.0,
                color: CustomColor.white0,
              ),
              onChanged: (value) {
                updateShowDomainItemList();
              },
            ),
          ),
        ],
      ),
    );
  }
}
