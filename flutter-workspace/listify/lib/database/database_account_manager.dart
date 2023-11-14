import 'dart:convert';

import '../domain/domain_account.dart';
import 'database_manager.dart';

import 'package:http/http.dart' as http;

class DatabaseAccountManager {
  static const String databaseAddress = "${DatabaseManager.databaseAddress}/account";

  static Future<String?> getIdOfAccount(String email, String password) async {
    String? accountId;

    final response = await http.get(Uri.parse("$databaseAddress.json"));
    final extractedData = json.decode(response.body) != null
        ? json.decode(response.body) as Map<String, dynamic>
        : null;

    if (extractedData != null) {
      extractedData.forEach((key, value) {
        if (value["email"] == email && value["password"] == password) {
          accountId = key;
        }
      });
    }
    return accountId;
  }

  static Future<String?> createAccount(String name, String email, String password) async {
    String? id;
    final response = await http.post(
      Uri.parse("$databaseAddress.json"),
      body: json.encode(
        {
          "email": email,
          "password": password,
        },
      ),
    );
    final extractedData = json.decode(response.body) != null
        ? json.decode(response.body) as Map<String, dynamic>
        : null;

    if (extractedData != null) {
      id = extractedData["name"];
    }

    return id;
  }

  static Future<DomainAccount?> getDataOfAccountID(String userKey) async {
    DomainAccount? account;

    final response = await http.get(Uri.parse("$databaseAddress.json"));
    final extractedData = json.decode(response.body) != null
        ? json.decode(response.body) as Map<String, dynamic>
        : null;

    if (extractedData != null) {
      extractedData.forEach((key, value) {
        if (key == userKey) {
          account = DomainAccount(key, value["name"], value["email"], value["password"]);
        }
      });
    }
    return account;
  }

  static Future<void> addItemToAccount(String itemName, String id) async {
    List<String> itemList = <String>[];

    final response = await http.get(Uri.parse("$databaseAddress/$id/items.json"));
    final extractedData = json.decode(response.body) != null
        ? json.decode(response.body) as Map<String, dynamic>
        : null;

    if (extractedData != null) {
      extractedData.forEach((key, value) {
        itemList.add(value["name"].toString().toLowerCase());
      });
    }

    if (!itemList.contains(itemName.toLowerCase())) {
      await http.post(
        Uri.parse("$databaseAddress/$id/items.json"),
        body: json.encode(
          {
            "name": itemName,
          },
        ),
      );
    }
  }

}