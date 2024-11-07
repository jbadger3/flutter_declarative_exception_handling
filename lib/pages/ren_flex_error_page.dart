import 'package:flutter/material.dart';
import 'package:flutter_declarative_exception_handling/detailed_exception.dart';

class RenFlexErrorPage extends DetailedException {
  RenFlexErrorPage({required super.title, required super.message});
}

class RenderFlexErrorPage extends StatelessWidget {
  const RenderFlexErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RenderFlex Example')),
      body: Center(
        child: Row(
          children: [
            const Icon(Icons.message),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title',
                    style: Theme.of(context).textTheme.headlineMedium),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed '
                  'do eiusmod tempor incididunt ut labore et dolore magna '
                  'aliqua. Ut enim ad minim veniam, quis nostrud '
                  'exercitation ullamco laboris nisi ut aliquip ex ea '
                  'commodo consequat.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
