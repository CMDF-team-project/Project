import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:team_project/additional_screens/splash_screen.dart';
import 'package:team_project/connectivity/connectivity_service.dart';
import 'package:team_project/firebase_options.dart';
import 'package:team_project/l10n/l10n.dart';
import 'package:team_project/screens/home_screen.dart';
import 'package:team_project/storage/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:team_project/app_localizations.dart' as app_localizations;
import 'package:team_project/locale_provider.dart';

late ConnectivityService connectionService;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  connectionService = await ConnectivityService(Connectivity()).init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MoodModel()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<MoodModel>(context).isDarkMode;
    final localeProvider = Provider.of<LocaleProvider>(context);

    ThemeData darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 39, 46, 37),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 39, 46, 37),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color.fromARGB(255, 17, 20, 16)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
        labelMedium: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Colors.white),
      ),
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Color.fromARGB(255, 17, 20, 16),
      ),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.white)),
    );

    ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 239),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 245, 245, 239),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 11, 58, 4), fontSize: 20),
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: const Color.fromARGB(255, 43, 114, 28).withOpacity(0.5)),
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 11, 58, 4), fontSize: 20),
      ),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 11, 58, 4))),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        app_localizations.AppLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: localeProvider.locale,
      theme: isDarkMode ? darkTheme : lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return SplashScreen();
        },
        '/home': (context) {
          return const HomeScreen();
        },
      },
    );
  }
}
