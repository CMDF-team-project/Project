import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:team_project/app_localizations.dart' as app_localizations;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userName;
  DateTime? dateOfBirth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localizations = app_localizations.AppLocalizations.of(context)!;
    userName = localizations.translate('userName') ?? 'User Name';
  }

  @override
  Widget build(BuildContext context) {
    final localizations = app_localizations.AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('userProfile') ?? 'User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/images/default_photo.jpg'),
            ),
            const SizedBox(height: 10),
            Text(
              userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (dateOfBirth != null) ...[
              const SizedBox(height: 10),
              Text(
                '${localizations.translate('dateOfBirth')}: ${dateOfBirth!.toLocal().toIso8601String().split('T').first}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 11, 58, 4)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                _changeNickname(context);
              },
              child: Text(localizations.translate('changeNickname') ?? 'Change Nickname'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 11, 58, 4)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                _changeDateOfBirth(context);
              },
              child: Text(localizations.translate('changeDateOfBirth') ?? 'Change Date of Birth'),
            ),
          ],
        ),
      ),
    );
  }

  void _changeNickname(BuildContext context) {
    final TextEditingController nicknameController = TextEditingController();
    final localizations = app_localizations.AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations.translate('changeNickname') ?? 'Change Nickname'),
          content: TextField(
            controller: nicknameController,
            decoration: InputDecoration(hintText: localizations.translate('enterNewNickname') ?? 'Enter new nickname'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(localizations.translate('cancel') ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userName = nicknameController.text.isNotEmpty ? nicknameController.text : localizations.translate('userName') ?? 'User Name';
                });
                Navigator.of(context).pop();
              },
              child: Text(localizations.translate('save') ?? 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _changeDateOfBirth(BuildContext context) async {
    DateTime? selectedDate = await showDialog(
      context: context,
      builder: (context) {
        DateTime focusedDay = dateOfBirth ?? DateTime.now();
        DateTime selectedDay = focusedDay;

        return AlertDialog(
          title: Text(app_localizations.AppLocalizations.of(context)!.translate('changeDateOfBirth') ?? 'Change Date of Birth'),
          content: SizedBox(
            height: 400,
            child: TableCalendar(
              firstDay: DateTime.utc(1900, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: (newSelectedDay, newFocusedDay) {
                setState(() {
                  selectedDay = newSelectedDay;
                  focusedDay = newFocusedDay;
                });
                Navigator.of(context).pop(newSelectedDay);
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                weekendStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                dowTextFormatter: (date, locale) {
                  return DateFormat.E(locale).format(date);
                },
              ),
              calendarStyle: CalendarStyle(
                defaultDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 39, 165, 66).withOpacity(0.5),
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 39, 165, 66).withOpacity(0.9),
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 39, 165, 66),
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                weekendDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 39, 165, 66).withOpacity(0.5),
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                defaultTextStyle: TextStyle(color: Colors.white),
                todayTextStyle: TextStyle(color: Colors.white),
                selectedTextStyle: TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(app_localizations.AppLocalizations.of(context)!.translate('cancel') ?? 'Cancel'),
            ),
          ],
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        dateOfBirth = selectedDate;
      });
    }
  }
}
