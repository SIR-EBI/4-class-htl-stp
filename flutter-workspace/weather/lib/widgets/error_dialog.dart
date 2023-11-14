import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final bool visibility;

  const ErrorDialog({
    Key? key,
    required this.visibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.heart_broken,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Wrong URL",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
