import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:team_project/additional_screens/welcome_screen.dart';

void main() {
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: Text('You are connected to the internet.'),
      ),
    );
  }
}