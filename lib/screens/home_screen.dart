import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:team_project/connectivity/core.dart';
import 'package:team_project/dialogue/mood_dialogue.dart';
import 'package:team_project/locale_provider.dart';
import 'package:team_project/screens/mood_page.dart';
import 'package:team_project/storage/provider.dart';
import 'package:team_project/app_localizations.dart' as app_localizations;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
  with ConnectionAwareMixin<HomeScreen>, DefaultConnectionAwareMixin<HomeScreen>
  implements RestartableStateInterface {

  @override
  Widget buildPage(BuildContext context) {
    final model = Provider.of<MoodModel>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = app_localizations.AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('home_title') ?? 'Home'),
        actions: [
          IconButton(
            onPressed: () {
              model.toggleDarkMode();
            }, 
            icon: const Icon(
              Icons.brightness_6,
              color: Color.fromARGB(255, 206, 203, 29),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.language,
              color: Color.fromARGB(255, 34, 58, 192),  
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(localizations.translate('select_language') ?? 'Select Language'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: L10n.all.map((locale) {
                      return ListTile(
                        title: Text(locale.languageCode.toUpperCase()),
                        onTap: () {
                          localeProvider.setLocale(locale);
                          Navigator.of(context).pop();
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: model.selectedDay ?? DateTime.now(),
                calendarFormat: CalendarFormat.month,
                locale: localeProvider.locale.languageCode,
                selectedDayPredicate: (day) {
                  return isSameDay(model.selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  model.selectDay(selectedDay);
                  showMoodDialog(context, selectedDay);
                },
                onPageChanged: (focusedDay) {},
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  titleTextFormatter: (date, locale) {
                    return localizations.translate('calendar_header') ?? '';
                  },
                ),
                daysOfWeekHeight: 30,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                  dowTextFormatter: (date, locale) {
                    return DateFormat.E(localeProvider.locale.languageCode).format(date);
                  },
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, _) {
                    return FutureBuilder<Color>(
                      future: model.getMoodColorByDate(date),
                      builder: (context, snapshot) {
                        Color backgroundColor = snapshot.data ?? const Color.fromARGB(255, 39, 165, 66);
                        Color textColor = Colors.white;

                        return Container(
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.5),
                            border: Border.all(color: textColor, width: 0.5),
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  todayBuilder: (context, date, _) {
                    return FutureBuilder<Color>(
                      future: model.getMoodColorByDate(date),
                      builder: (context, snapshot) {
                        Color backgroundColor = snapshot.data ?? Colors.grey;
                        Color textColor = Colors.white;

                        return Container(
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.9),
                            border: Border.all(color: textColor, width: 0.5),
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  selectedBuilder: (context, day, _) {
                    return FutureBuilder<Color>(
                      future: model.getMoodColorByDate(day),
                      builder: (context, snapshot) {
                        Color backgroundColor = snapshot.data ?? Colors.blue;
                        Color textColor = Colors.white;

                        return Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(color: textColor, width: 0.5),
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
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
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMoodEntryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}