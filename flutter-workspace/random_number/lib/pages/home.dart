import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  double min = 1;
  double max = 6;
  int rand = 0;

  int newRandInBound(int min, int max) {
    return Random().nextInt(max - min + 1) + min;
  }

  @override
  Widget build(BuildContext context) {
    rand = newRandInBound(min.toInt(), max.toInt());

    if (ModalRoute.of(context)!.settings.arguments != null) {
      data = ModalRoute.of(context)!.settings.arguments as Map<String, double>;
      min = data["min"];
      max = data["max"];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Number"),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Text(
                        "Random numbers from $min to $max",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.info)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings', arguments: {
                  "min": min,
                  "max": max,
                });
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$rand",
              style: const TextStyle(
                fontSize: 50.0,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rand = newRandInBound(min.toInt(), max.toInt());
                });
              },
              child: const Text("New Random"),
            ),
          ],
        ),
      ),
    );
  }
}
