import 'package:flutter/material.dart';

import './subject.dart';
import './subject_visualisation.dart';

class SubjectStatistics extends StatefulWidget {
  final List<Subject> subjects;

  final Function getAllSubjects;
  final Function getTimeOfAll;
  final Function getTimeOfSubject;

  const SubjectStatistics({
    Key? key,
    required this.subjects,
    required this.getAllSubjects,
    required this.getTimeOfAll,
    required this.getTimeOfSubject,
  }) : super(key: key);

  @override
  State<SubjectStatistics> createState() => _SubjectStatisticsState();
}

class _SubjectStatisticsState extends State<SubjectStatistics> {
  List<String> activeSubjects = <String>[];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Container(
        alignment: Alignment.center,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.getAllSubjects().length,
            itemBuilder: (BuildContext context, int index) {
              return SubjectVisualisation(
                subject: widget.getAllSubjects()[index],
                allTime: widget.getTimeOfAll(),
                myTime: widget.getTimeOfSubject(widget.getAllSubjects()[index]),
              );
            },),
      ),
    );
  }
}
