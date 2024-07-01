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
            const Text(
              'No active connection',
              style: TextStyle(fontSize: 20),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 43, 114, 28), 
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ), 
              child: const Text(
                'Retry',
                style: TextStyle(color: Colors.white, fontSize: 20),  
              )
            )
          ],
        ),
      ),
    );
  }
}