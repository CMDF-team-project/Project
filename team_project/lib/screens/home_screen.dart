import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:team_project/connection.dart';
import 'package:team_project/storage/provider.dart';
import 'mood_page.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
  with ConnectionAwareMixin<HomeScreen>, DefaultConnectionAwareMixin<HomeScreen>
  implements RestartableStateInterface {

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  void _showMoodDialog(BuildContext context, DateTime selectedDay) async {
    String formattedDate = DateFormat('d MMMM, yyyy').format(selectedDay);
    DatabaseReference ref = _database.ref().child('mood_entries').child(formattedDate);

    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      String mood = data['mood'];
      String description = data['description'];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mood on $formattedDate'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your mood today: $mood'),
                Text('Describe your day : $description'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mood on $formattedDate'),
            content: const Text('No notes for this day.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    final model = Provider.of<MoodModel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: model.selectedDay ?? DateTime.now(),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(model.selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  model.selectDay(selectedDay);
                  _showMoodDialog(context, selectedDay);
                },
                onPageChanged: (focusedDay) {},
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                daysOfWeekHeight: 30,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.equalizer),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MoodInputScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}