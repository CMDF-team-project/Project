import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_project/app_localizations.dart';
import 'package:team_project/locale_provider.dart';
import 'package:team_project/mood.dart';
import 'package:team_project/storage/provider.dart';
import 'package:team_project/app_localizations.dart' as app_localizations;

class AddMoodEntryScreen extends StatelessWidget {
  const AddMoodEntryScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var localizedStrings = AppLocalizations.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = app_localizations.AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
         title: Text(localizations.translate('addMoodEntry') ?? 'Add Mood Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MoodModel>(
          builder: (context, moodModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<Mood>(
                  dropdownColor: Color.fromARGB(255, 19, 73, 10),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: localizations.translate('selectMoodLabel') ?? 'Select Mood',
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
                  decoration: InputDecoration(
                    labelText: localizations.translate('describeDayLabel') ?? 'Describe Day',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 11, 58, 4)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () => moodModel.saveMoodData(context),
                  child: Text(localizations.translate('saveMoodButton') ?? 'Save'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
