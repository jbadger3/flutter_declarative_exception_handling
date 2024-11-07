import 'package:flutter/material.dart';
import 'package:flutter_declarative_exception_handling/detailed_exception.dart';
import 'package:flutter_declarative_exception_handling/pages/ren_flex_error_page.dart';

import '../app_state.dart';

class FlutterErrorExamplesPage extends StatelessWidget {
  const FlutterErrorExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterError examples'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  final myList = [1, 2, 3];
                  final _ = myList[10]; //RangeError
                },
                child: const Text('Generate unhandled error')),
            ElevatedButton(
                onPressed: () {
                  throw 'String as an error';
                },
                child: const Text('Throw a string')),
            ElevatedButton(
                onPressed: () {
                  throw CustomException(
                      title: 'Error', message: 'Sorry for messing things up.');
                },
                child: const Text('Generate unhandled exception')),
            ElevatedButton(
              onPressed: () {
                try {
                  throw CustomException(
                      title: 'Handled Exception',
                      message:
                          "No worries.  There was an exception, but the app didn't break.");
                } on DetailedException catch (e) {
                  AppState().detailedException.value = e;
                  //Fix app state
                } catch (e, stack) {}
              },
              child: const Text('Generate and handle exception'),
            ),
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RenderFlexErrorPage())),
              title: const Text('RenderFlex Error Example'),
              trailing: const Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomException extends DetailedException {
  CustomException({required super.title, required super.message});
}
