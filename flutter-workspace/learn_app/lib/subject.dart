import 'dart:math';

import 'package:flutter/cupertino.dart';

class Subject {
  int id;
  int minutes;
  String subject;
  String date;

  int get getId {
    return id;
  }
  int get getMinutes {
    return minutes;
  }
  String get getSubject {
    return subject;
  }
  String get getDate {
    return date;
  }

  Subject({required this.id, required this.minutes, required this.subject, required this.date});

  @override
  int compareTo(Subject other) {
    return minutes.compareTo(other.getMinutes);
  }
}
