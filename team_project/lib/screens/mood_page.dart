import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_project/storage/provider.dart';

class MoodInputScreen extends StatelessWidget {
  const MoodInputScreen({Key? key});

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
              children: [
                DropdownButton<String>(
                  hint: const Text('Select your mood'),
                  value: moodModel.selectedMood?.isEmpty ?? true ? null : moodModel.selectedMood,
                  onChanged: (String? newValue) {
                    moodModel.setSelectedMood(newValue);
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
                  controller: moodModel.descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => moodModel.saveMoodData(context),
                  child: const Text('Save Mood Data'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
