import 'package:flutter/material.dart';
import 'package:flutter_test_eberhardt/domain/db_utils.dart';
import 'package:flutter_test_eberhardt/widgets/error_dialog.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<String> cities = <String>["Empty"];
  String dropdownValue = "Empty";
  bool visibility = false;

  TextEditingController urlController = TextEditingController();

  void loadCities(String url) async {
    cities = await DBUtils.getAllCityNames(url);
    if (cities.isEmpty) {
      cities = <String>["Empty"];
      dropdownValue = "Empty";
      visibility = true;
    } else {
      cities.sort();
      dropdownValue = cities.first;
      visibility = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 600.0,
              ),
              child: Column(
                children: [
                  // error text
                  ErrorDialog(visibility: visibility),

                  // url input field
                  TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      hintText: "Enter Url without .json",
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                  // spacing
                  const SizedBox(height: 30),

                  // read from database button
                  ElevatedButton(
                    child: const Text("Load Cities from DB"),
                    onPressed: () {
                      loadCities(urlController.text);
                    },
                  ),

                  // spacing
                  const SizedBox(height: 10),

                  // city dropdown
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 43.0,
                    ),
                    underline: Container(
                      height: 2,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: cities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, {
            "url": urlController.text,
            "city": dropdownValue,
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
    );
  }
}
