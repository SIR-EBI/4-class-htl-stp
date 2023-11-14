import 'package:flutter/material.dart';

class SubjectListTile extends StatefulWidget {
  final Function removeSubject;

  final int id;
  final int minutes;
  final String subject;
  final String date;

  const SubjectListTile(
      this.removeSubject, this.id, this.minutes, this.subject, this.date,
      {Key? key})
      : super(key: key);

  @override
  State<SubjectListTile> createState() => _SubjectListTile();
}

class _SubjectListTile extends State<SubjectListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          widget.minutes.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(widget.subject),
      subtitle: Text(widget.date),
      trailing: ElevatedButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          widget.removeSubject(widget.id);
        },
      ),
    );
  }
}
