import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodModel with ChangeNotifier {
  DateTime? _selectedDay;
  Map<String, dynamic> _moodData = {};
  String? _selectedMood;
  final TextEditingController _descriptionController = TextEditingController();
  final DatabaseReference _moodEntriesRef = FirebaseDatabase.instance.ref().child('mood_entries');


  DateTime? get selectedDay => _selectedDay;
  Map<String, dynamic> get moodData => _moodData;
  String? get selectedMood => _selectedMood;
  TextEditingController get descriptionController => _descriptionController;

  void selectDay(DateTime? selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  void setMoodData(Map<String, dynamic> moodData) {
    _moodData = moodData;
    notifyListeners();
  }

  void setSelectedMood(String? mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  Future<bool> checkExistingEntry() async {
    DateTime now = DateTime.now();
    String today = DateFormat('d MMMM, yyyy').format(now);

    DataSnapshot snapshot = await _moodEntriesRef.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> moodEntries = snapshot.value as Map<dynamic, dynamic>;
      return moodEntries.containsKey(today);
    }
    return false;
  }

  Future<void> saveMoodData(BuildContext context) async {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mood')),
      );
      return;
    }

    if (await checkExistingEntry()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood data already exists for today')),
      );
      return;
    }

    try {
      String formattedDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
      await _moodEntriesRef.child(formattedDate).set({
        'mood': _selectedMood,
        'description': _descriptionController.text,
        'date': formattedDate,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood data saved successfully')),
      );

      _selectedMood = null;
      _descriptionController.clear();
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save mood data: $e')),
      );
      print('Error saving mood data: $e');
    }
  }
}