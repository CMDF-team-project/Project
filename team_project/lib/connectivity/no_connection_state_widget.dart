import 'package:flutter/material.dart';

class NoConnectionState extends StatelessWidget {
  const NoConnectionState({
    super.key,
    required this.onRetry,
  });
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No active connection'),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry'))
          ],
        ),
      ),
    );
  }
}