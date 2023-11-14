import 'package:flutter/material.dart';

class SubjectVisualisation extends StatefulWidget {
  final String subject;
  final int allTime;
  final int myTime;

  const SubjectVisualisation({
    Key? key,
    required this.subject,
    required this.allTime,
    required this.myTime,
  }) : super(key: key);

  @override
  State<SubjectVisualisation> createState() => _SubjectVisualisationState();
}

class _SubjectVisualisationState extends State<SubjectVisualisation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      child: Column(
        children: [
          const Spacer(flex: 1),
          Text(widget.subject),
          Text(widget.myTime.toString()),
          RotatedBox(
            quarterTurns: 1,
            child: SizedBox(
              width: 100,
              height: 20,
              child: LinearProgressIndicator(
                value: widget.myTime == 0 ? 1 : 1 - 1 / widget.allTime * widget.myTime,
                backgroundColor: Colors.lightBlue,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
