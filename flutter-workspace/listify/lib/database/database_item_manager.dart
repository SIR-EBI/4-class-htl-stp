import 'dart:convert';

import 'package:listify_app/database/database_account_manager.dart';

import '../domain/domain_item.dart';
import 'database_manager.dart';

import 'package:http/http.dart' as http;

class DatabaseItemManager {
  static const String databaseAddress =
      "${DatabaseManager.databaseAddress}/item";

  static Future<List<DomainItem>> loadItemsFromDatabase(
      String accountId) async {
    List<DomainItem> domainItemList = <DomainItem>[];

    final accountResponse =
    await http.get(Uri.parse("${DatabaseAccountManager.databaseAddress}/$accountId/items.json"));
    final accountExtractedData = json.decode(accountResponse.body) != null
        ? json.decode(accountResponse.body) as Map<String, dynamic>
        : null;

    if (accountExtractedData != null) {
      accountExtractedData.forEach((key, value) {
        domainItemList.add(DomainItem(
          key,
          value["name"],
        ));
      });
    }

    final listResponse = await http.get(Uri.parse("$databaseAddress.json"));
    final listExtractedData = json.decode(listResponse.body) != null
        ? json.decode(listResponse.body) as Map<String, dynamic>
        : null;

    if (listExtractedData != null) {
      listExtractedData.forEach((key, value) {
        domainItemList.add(DomainItem(
          key,
          value["name"],
        ));
      });
    }

    return domainItemList;
  }
}
