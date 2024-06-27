import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addMoodNote(String userId, DateTime date, String mood, {String? note, String? imageUrl, String? videoUrl}) async {
  try {
    await FirebaseFirestore.instance.collection('MoodNotes').add({
      'userId': userId,
      'date': date,
      'mood': mood,
      'note': note ?? '',
      'imageUrl': imageUrl ?? '',
      'videoUrl': videoUrl ?? '',
    });
  } catch (e) {
    print('Error adding mood note: $e');
    throw e;
  }
}
