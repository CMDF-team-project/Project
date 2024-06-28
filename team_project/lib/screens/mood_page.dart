import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MoodInputScreen extends StatefulWidget {
  const MoodInputScreen({super.key});

  @override
  _MoodInputScreenState createState() => _MoodInputScreenState();
}

class _MoodInputScreenState extends State<MoodInputScreen> {
  String? _selectedMood;
  final TextEditingController _descriptionController = TextEditingController();
  final DatabaseReference _moodEntriesRef = FirebaseDatabase.instance.ref().child('mood_entries');

  Future<bool> _checkExistingEntry() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('mood_entries');
    DataSnapshot snapshot = await ref.get();
    DateTime now = DateTime.now();
    String today = DateFormat('d MMMM, yyyy').format(now);
    
    if (snapshot.exists) {
      Map<dynamic, dynamic> moodEntries = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in moodEntries.values) {
        String entryDateStr = entry['date'];
        if (entryDateStr == today) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> _saveMoodData() async {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a mood')));
      return;
    }

    if (await _checkExistingEntry()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mood data already exists for today')));
      return;
    }

    try {
      String formattedDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
      await _moodEntriesRef.child(formattedDate).set({
        'mood': _selectedMood,
        'description': _descriptionController.text,
        'date': formattedDate,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mood data saved successfully')));

      setState(() {
        _selectedMood = null;
        _descriptionController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save mood data: $e')));
      print('Error saving mood data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Mood Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: const Text('Select your mood'),
              value: _selectedMood,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMood = newValue;
                });
              },
              items: <String>['Happy', 'Sad', 'Neutral', 'Excited', 'Angry']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMoodData,
              child: const Text('Save Mood Data'),
            ),
          ],
        ),
      ),
    );
  }
}