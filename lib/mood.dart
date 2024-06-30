import 'package:flutter/material.dart';

class Mood {
  final String name;
  final Color color;

  Mood({
    required this.name,
    required this.color,
  });

  Color get moodColor => color;
  String get moodName => name;
}

List<Mood> moods = [
  Mood(name: 'Happy', color: Color.fromARGB(255, 255, 196, 0)),
  Mood(name: 'Sad', color: Color.fromARGB(213, 85, 113, 128)),
  Mood(name: 'Neutral', color: Colors.grey),
  Mood(name: 'Excited', color: Colors.green),
  Mood(name: 'Angry', color: Colors.red),
];

Color getColorByName(String name) {
  Mood? mood = moods.firstWhere((mood) => mood.name == name, orElse: () => Mood(name: '', color: Colors.grey));
  return mood.color;
}