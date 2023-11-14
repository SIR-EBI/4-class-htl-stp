import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SubjectFloatingActionButton extends StatefulWidget {
  final Function addSubject;

  const SubjectFloatingActionButton({Key? key, required this.addSubject})
      : super(key: key);

  @override
  State<SubjectFloatingActionButton> createState() =>
      _SubjectFloatingActionButton();
}

class _SubjectFloatingActionButton extends State<SubjectFloatingActionButton> {
  String subject = "Pos";
  int minutes = 0;
  String date = "";

  var items = [
    "Pos",
    "Nvs",
    "Dbi",
    "Am",
    "D",
    "E",
    "Bsp",
    "Tinf",
    "Ggp",
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  height: 440,
                  child: Column(
                    children: [
                      const Spacer(flex: 1),
                      DropdownButton<String>(
                        value: subject,
                        items: items.map((String subject) {
                          return DropdownMenuItem(
                            value: subject,
                            child: Text(subject),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            subject = newValue!;
                          });
                        },
                      ),
                      const Spacer(flex: 1),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          maxLength: 3,
                          decoration: const InputDecoration(
                            hintText: "Minutes",
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              minutes = int.parse(value);
                            }
                          },
                        ),
                      ),
                      const Spacer(flex: 1),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 120,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime newDateTime) {
                            date = DateFormat("yyyy-MM-dd").format(newDateTime);
                          },
                        ),
                      ),
                      const Spacer(flex: 1),
                      ElevatedButton(
                        child: const Text("Add"),
                        onPressed: () {
                          if (date.trim().isEmpty) {
                            date =
                                DateFormat("yyyy-MM-dd").format(DateTime.now());
                          }
                          widget.addSubject(minutes, subject, date);
                        },
                      ),
                      const Spacer(flex: 8),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
