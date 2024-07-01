import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

void showMoodDialog(BuildContext context, DateTime selectedDay) async {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  String formattedDate = DateFormat('dd MMMM, yyyy').format(selectedDay);
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
                'Your mood on this day: $mood'
                ),
              Text('Description: $description'
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await ref.remove();
                Navigator.of(context).pop(); 
              },
              child: Text(
                'Delete'
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
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
          title: Text('Mood on $formattedDate'),
          content: const Text('No notes for this day.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
