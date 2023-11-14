import 'package:flutter/material.dart';

import './subject_floatingActionButton.dart';
import './subject_listview.dart';
import './subject_statistics.dart';

import './subject.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Subject> subjects = <Subject>[];
  int id = 0;

  void addSubject(int minutes, String subject, String date) {
    setState(() {
      subjects.insert(
          0, Subject(id: id, minutes: minutes, subject: subject, date: date));
      id++;
    });
  }

  void removeSubject(int id) {
    setState(() {
      var toRemove = [];
      for (var s in subjects) {
        if (s.getId == id) {
          toRemove.add(s);
        }
      }
      subjects.removeWhere((s) => toRemove.contains(s));
    });
  }

  List<String> getAllSubjects() {
    Map<String, int> subjectMinutes = {};

    for (var subject in subjects) {
      if (subjectMinutes.containsKey(subject.getSubject)) {
        subjectMinutes.update(subject.getSubject, (value) => value + subject.getMinutes);
      }
      else {
        subjectMinutes[subject.getSubject] = subject.getMinutes;
      }
    }
    var sortedByKeyMap = Map.fromEntries(
        subjectMinutes.entries.toList()..sort((s1, s2) => s1.value.compareTo(s2.value)*-1)
    );

    return sortedByKeyMap.keys.toList();
  }

  int getTimeOfAll() {
    int time = 0;
    for (var s in subjects) {
      time += s.getMinutes;
    }
    return time;
  }

  int getTimeOfSubject(String subject) {
    int time = 0;
    for (var s in subjects) {
      if (s.getSubject == subject) {
        time += s.getMinutes;
      }
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("My studies"),
        ),
        body: Column(
          children: [
            SubjectStatistics(
              subjects: subjects,
              getAllSubjects: getAllSubjects,
              getTimeOfAll: getTimeOfAll,
              getTimeOfSubject: getTimeOfSubject,
            ),
            SubjectListView(
              removeSubject: removeSubject,
              subjects: subjects,
            ),
          ],
        ),
        floatingActionButton: SubjectFloatingActionButton(addSubject: addSubject,),
      ),
    );
  }
}
