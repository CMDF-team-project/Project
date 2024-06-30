import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_project/mood.dart';

class MoodModel with ChangeNotifier {
  DateTime? _selectedDay;
  Map<String, dynamic> _moodData = {};
  Mood? _selectedMood;
  final TextEditingController _descriptionController = TextEditingController();
  DatabaseReference _moodEntriesRef = FirebaseDatabase.instance.ref().child('mood_entries');

  DateTime? get selectedDay => _selectedDay;
  Map<String, dynamic> get moodData => _moodData;
  Mood? get selectedMood => _selectedMood;
  TextEditingController get descriptionController => _descriptionController;

  void selectDay(DateTime? selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  void setMoodData(Map<String, dynamic> moodData) {
    _moodData = moodData;
    notifyListeners();
  }

  void setSelectedMood(Mood? mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  void  setDatabaseReference(DatabaseReference reference) {
    _moodEntriesRef = reference;
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

  Future<Color> getMoodColorByDate(DateTime date) async {
    String formattedDate = DateFormat('d MMMM, yyyy').format(date);
    DataSnapshot snapshot = await _moodEntriesRef.child(formattedDate).get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      return getColorByName(data['mood']);
    }
    return Color.fromARGB(255, 43, 114, 28);
  }

  Future<void> saveMoodData(BuildContext context) async {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Color.fromARGB(255, 11, 58, 4), content: Text('Please select a mood',
        style: TextStyle(color: Colors.white),)),
      );
      return;
    }

    if (await checkExistingEntry()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Color.fromARGB(255, 11, 58, 4), content: Text('Mood data already exists for today',
        style: TextStyle(color: Colors.white),)),
      );

      _selectedMood = null;
      _descriptionController.clear();
      return;
    }

    try {
      String formattedDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
      await _moodEntriesRef.child(formattedDate).set({
        'mood': _selectedMood!.name,
        'description': _descriptionController.text,
        'date': formattedDate,
      });


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Color.fromARGB(255, 11, 58, 4), content: Text('Mood data saved successfully',
        style: TextStyle(color: Colors.white),)),
      );

      _selectedMood = null;
      _descriptionController.clear();

      notifyListeners();
    } catch (e) {
      print('Error saving mood data: $e');
    }
  }
}