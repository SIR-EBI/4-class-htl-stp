import 'package:flutter/material.dart';
import 'package:lern_app/subject_listtile.dart';

import './subject.dart';

class SubjectListView extends StatefulWidget {
  final Function removeSubject;
  final List<Subject> subjects;

  const SubjectListView({Key? key, required this.removeSubject, required this.subjects}) : super(key: key);

  @override
  State<SubjectListView> createState() => _SubjectListViewState();
}

class _SubjectListViewState extends State<SubjectListView> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75 - 95,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return SubjectListTile(
              widget.removeSubject,
              widget.subjects[index].getId,
              widget.subjects[index].getMinutes,
              widget.subjects[index].getSubject,
              widget.subjects[index].getDate
          );
        },
      ),
    );
  }
}
