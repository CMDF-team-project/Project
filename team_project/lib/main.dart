import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:team_project/additional_screens/welcome_screen.dart';
import 'package:team_project/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        hasInternet = result != ConnectivityResult.none;
        reloadAppIfNeeded();
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = result != ConnectivityResult.none;
    });
  }

  void reloadApp() {
    WidgetsBinding.instance.addPostFrameCallback((_) => runApp(const MyApp()));
  }

  void reloadAppIfNeeded() {
    if (!hasInternet) {
      reloadApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: hasInternet ? const SplashScreen() : const HomeScreen(),
    );
  }
}