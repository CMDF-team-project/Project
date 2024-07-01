import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:team_project/additional_screens/welcome_screen.dart';
import 'package:team_project/firebase_options.dart';
import 'package:team_project/storage/provider.dart';
import 'connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'l10n/l10n.dart';

late final ConnectivityService connectionService;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  connectionService = await ConnectivityService(Connectivity()).init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,  // Custom AppLocalizations delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('ru', 'RU'), // Russian
      ],
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.translate('title') ?? 'Loading...'),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)?.translate('welcome') ?? 'Loading...'),
      ),
    );
  }
}
