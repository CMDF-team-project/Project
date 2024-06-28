import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import'dart:io';


class MoodInputScreen extends StatefulWidget {
  const MoodInputScreen({super.key});

  @override
  _MoodInputScreenState createState() => _MoodInputScreenState();
}

class _MoodInputScreenState extends State<MoodInputScreen> {
  String? _selectedMood;
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  File? _video;
  String? _imageUrl;
  String? _videoUrl;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        setState(() {
          _imageUrl = pickedFile.path;
        });
      } else {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        setState(() {
          _videoUrl = pickedFile.path;
        });
      } else {
        setState(() {
          _video = File(pickedFile.path);
        });
      }
    }
  }

  void _saveMoodData() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a mood')));
      return;
    }

    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child('mood_entries').push();
      ref.set({
        'mood': _selectedMood,
        'description': _descriptionController.text,
        'image_path': _image?.path,
        'video_path': _video?.path,
        'date': DateTime.now().toString(),
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mood data saved successfully')));

      setState(() {
        _selectedMood = null;
        _descriptionController.clear();
        _image = null;
        _video = null;
        _imageUrl = null;
        _videoUrl = null;
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
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
                _image != null ? Image.file(_image!, width: 50, height: 50) : Container(),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickVideo,
                  child: const Text('Pick Video'),
                ),
                _video != null ? const Icon(Icons.videocam, size: 50) : Container(),
              ],
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