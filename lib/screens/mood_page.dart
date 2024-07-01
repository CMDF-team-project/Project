import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_project/mood.dart';
import 'package:team_project/storage/provider.dart';

class AddMoodEntryScreen extends StatelessWidget {
  const AddMoodEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Mood Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MoodModel>(
          builder: (context, moodModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<Mood>(
                  dropdownColor: Color.fromARGB(255, 196, 238, 189),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 219, 248, 214),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 74, 148, 84)),
                    ),
                    labelText: 'Select your mood',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 135, 173, 127)),
                    border: OutlineInputBorder(),
                  ),
                  value: moodModel.selectedMood,
                  onChanged: (Mood? newValue) {
                    moodModel.setSelectedMood(newValue);
                  },
                  items: moods.map((Mood mood) {
                    return DropdownMenuItem<Mood>(
                      value: mood,
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: mood.color),
                          const SizedBox(width: 8),
                          Text(mood.name,
                              style: TextStyle(color: Color.fromARGB(255, 12, 48, 5))),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                TextField(
                  style: TextStyle(color: Color.fromARGB(255, 12, 48, 5)),
                  controller: moodModel.descriptionController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 219, 248, 214),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 74, 148, 84)),
                    ),
                    labelText: 'Describe your day (* ^ ω ^)',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 135, 173, 127)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 23, 100, 11)),
                    foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                  ),
                  onPressed: () => moodModel.saveMoodData(context),
                  child: Text('Save Mood'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
