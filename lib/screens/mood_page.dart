import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_project/mood.dart';
import 'package:team_project/providers/provider.dart';
import 'package:team_project/app_localizations.dart';
import 'package:team_project/providers/locale_provider.dart';
import 'package:team_project/app_localizations.dart' as app_localizations;

class AddMoodEntryScreen extends StatelessWidget {
  const AddMoodEntryScreen({super.key});

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
                  dropdownColor: Color.fromARGB(255, 196, 238, 189),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 219, 248, 214),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 74, 148, 84)),
                    ),
                    labelText: localizations.translate('selectMoodLabel') ?? 'Select Mood',
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 219, 248, 214),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 74, 148, 84)),
                    ),
                    labelText: localizations.translate('describeDayLabel') ?? 'Describe Day',
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
