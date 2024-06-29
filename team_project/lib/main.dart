import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:team_project/additional_screens/welcome_screen.dart';
import 'package:team_project/firebase_options.dart';
import 'package:team_project/storage/provider.dart';
import 'connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

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
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}