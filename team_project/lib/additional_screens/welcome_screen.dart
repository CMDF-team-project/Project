import 'package:flutter/material.dart';
import 'package:team_project/custom%20painter/combined_painter.dart';
import 'package:team_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _sunController;
  late Animation<double> _sunAnimation;

  late AnimationController _raysController;
  late Animation<double> _raysAnimation;
  
  @override
  void initState() {
    super.initState();

    _sunController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _sunAnimation = Tween<double>(begin: 0, end: 0.8).animate(
      CurvedAnimation(parent: _sunController, curve: Curves.easeInOut),
    );

    _raysController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _raysAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _raysController, curve: Curves.easeInOut),
    );

    _sunController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      _raysController.forward();
    });

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _sunController.dispose();
    _raysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 141, 218, 248),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_sunAnimation, _raysAnimation]),
          builder: (context, child) {
            return CustomPaint(
              painter: CombinedPainter(_sunAnimation.value * 100, 0, _raysAnimation.value, 30, 100, 190, 20, 50),
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            );
          },
        ),
      ),
    );
  }
}
