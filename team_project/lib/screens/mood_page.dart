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
        title: const Text('Add Mood Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MoodModel>(
          builder: (context, moodModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<Mood>(
                  decoration: const InputDecoration(
                    labelText: 'Select your mood',
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
                          Text(mood.name),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: moodModel.descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Describe your day (* ^ ω ^)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 43, 114, 28)),
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
