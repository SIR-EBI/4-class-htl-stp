import 'dart:convert';

import 'package:listify_app/database/database_manager.dart';
import 'package:listify_app/domain/domain_item.dart';
import 'package:listify_app/domain/domain_list.dart';

import 'package:http/http.dart' as http;
import 'package:listify_app/domain/domain_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseListManager {
  static const String databaseAddress =
      "${DatabaseManager.databaseAddress}/list";

  static Future<List<DomainList>> loadListFromDatabase() async {
    List<DomainList> domainListList = <DomainList>[];

    final response = await http.get(Uri.parse("$databaseAddress.json"));
    final extractedData = json.decode(response.body) != null
        ? json.decode(response.body) as Map<String, dynamic>
        : null;

    if (extractedData != null) {
      extractedData.forEach((key, value) async {
        String name = value["name"];
        String ownerId = value["ownerId"];
        List<String> memberIdList = getMemberIdsFromJson(value["members"]);
        List<DomainListItem> domainListItemList =
            getItemsFromJson(value["items"]);

        final prefs = await SharedPreferences.getInstance();
        String savedId = prefs.getString('accountId') ?? "";

        if (savedId == ownerId || memberIdList.contains(savedId)) {
          domainListList.add(DomainList(
            key,
            name,
            ownerId,
            memberIdList,
            domainListItemList,
          ));
        }
      });
    }
    return domainListList;
  }

  static List<String> getMemberIdsFromJson(Map<String, dynamic>? json) {
    List<String> memberIdList = <String>[];

    if (json != null) {
      json.forEach((key, value) {
        if (value["member_id"] != null) {
          memberIdList.add(
            value["member_id"],
          );
        }
      });
    }

    return memberIdList;
  }

  static List<DomainListItem> getItemsFromJson(Map<String, dynamic>? json) {
    List<DomainListItem> domainListItemList = <DomainListItem>[];

    if (json != null) {
      json.forEach((key, value) {
        domainListItemList.add(
          DomainListItem(
            key,
            value["name"],
            value["amount"],
          ),
        );
      });
    }

    return domainListItemList;
  }

  static Future<void> createNewList(String name) async {
    final prefs = await SharedPreferences.getInstance();
    String accountId = prefs.getString('accountId') ?? "";
    http.post(
      Uri.parse("$databaseAddress.json"),
      body: json.encode(
        {
          "name": name,
          "ownerId": accountId,
        },
      ),
    );
  }

  static void addItemToList(DomainList list, DomainItem item, String amount) {
    http.post(
      Uri.parse("$databaseAddress/${list.id}/items.json"),
      body: json.encode(
        {
          "name": item.name,
          "amount": amount,
        },
      ),
    );
  }

  static void addMemberToList(String listId, String memberId) {
    http.post(
      Uri.parse("$databaseAddress/$listId/members.json"),
      body: json.encode(
        {
          "member_id": memberId,
        },
      ),
    );
  }

  static void removeItemFromList(String listId, String itemId) {
    http.delete(
      Uri.parse("$databaseAddress/$listId/items/$itemId.json"),
    );
  }

  static void deleteList(String listId) {
    http.delete(
      Uri.parse("$databaseAddress/$listId.json"),
    );
  }
}
