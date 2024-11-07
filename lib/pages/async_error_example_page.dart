import 'package:flutter/material.dart';

class AsyncErrorExamplePage extends StatelessWidget {
  const AsyncErrorExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asynchrounous Error Example'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final myList = [1, 2, 3];
              final _ = myList[10]; //RangeError
            },
            child: const Text('Generate asynchronous error')),
      ),
    );
  }
}
