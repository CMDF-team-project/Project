import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoodCalendarPage extends StatelessWidget {
  final String userId;

  MoodCalendarPage(this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Calendar'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('MoodNotes')
            .where('userId', isEqualTo: userId)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final moodNotes = snapshot.data!.docs;
          return ListView.builder(
            itemCount: moodNotes.length,
            itemBuilder: (ctx, index) {
              final moodNote = moodNotes[index];
              return ListTile(
                title: Text('Date: ${moodNote['date']}'),
                subtitle: Text('Mood: ${moodNote['mood']}'),
                onTap: () {
                  // Показать подробную информацию о заметке для выбранного дня
                  // Можно использовать showModalBottomSheet или Navigator для перехода на новый экран
                },
              );
            },
          );
        },
      ),
    );
  }
}
