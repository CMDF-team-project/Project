import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team_project/connectivity/no_connection_state_widget.dart';

void main() {
  testWidgets('NoConnectionState widget test', (WidgetTester tester) async {
    bool retryPressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoConnectionState(
            onRetry: () {
              retryPressed = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('No active connection'), findsOneWidget);

    expect(find.byType(OutlinedButton), findsOneWidget);

    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();
    expect(retryPressed, true);
  });
}
