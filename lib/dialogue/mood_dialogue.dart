import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

void showMoodDialog(BuildContext context, DateTime selectedDay) async {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  String formattedDate = DateFormat('d MMMM, yyyy').format(selectedDay);
  DatabaseReference ref = database.ref().child('mood_entries').child(formattedDate);

  DataSnapshot snapshot = await ref.get();
  if (snapshot.exists) {
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    String mood = data['mood'];
    String description = data['description'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mood on $formattedDate'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your mood on this day: $mood',
                style: TextStyle(color: Color.fromARGB(255, 11, 58, 4)),
                ),
              Text('Description: $description',
              style: TextStyle(color: Color.fromARGB(255, 11, 58, 4)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close',
              style: TextStyle(color: Color.fromARGB(255, 11, 58, 4)),),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mood on $formattedDate',
          style: TextStyle(color: Color.fromARGB(255, 11, 58, 4)),),
          content: const Text('No notes for this day.',
          style: TextStyle(color: Color.fromARGB(255, 11, 58, 4)),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close',
              style: TextStyle(color: Color.fromARGB(255, 11, 58, 4)),),
            ),
          ],
        );
      },
    );
  }
}
