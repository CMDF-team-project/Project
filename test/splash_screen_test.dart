import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team_project/additional_screens/splash_screen.dart';
import 'package:team_project/screens/home_screen.dart';

void main() {
  testWidgets('SplashScreen shows animated painters and navigates to HomeScreen', (WidgetTester tester) async {
    
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/', 
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => const HomeScreen(),
      },
    ));

    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(CustomPaint), findsWidgets);

    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(SplashScreen), findsNothing);

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
