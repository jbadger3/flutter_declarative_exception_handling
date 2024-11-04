import 'package:flutter/material.dart';

import 'package:flutter_declarative_exception_handling/app_state.dart';
import 'package:flutter_declarative_exception_handling/detailed_exception.dart';
import 'package:flutter_declarative_exception_handling/pages/ren_flex_error_page.dart';

class HomePageException extends DetailedException {
  HomePageException({required super.title, required super.message});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool buildError = false;

  @override
  void initState() {
    AppState().detailedException.addListener(_showErrorMessage);
    super.initState();
  }

  @override
  void dispose() {
    AppState().detailedException.removeListener(_showErrorMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (buildError) {
      throw Exception('Error rebuilding');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  final myList = [1, 2, 3];
                  final _ = myList[10]; //RangeError
                },
                child: const Text('Generate unhandled error')),
            ElevatedButton(
                onPressed: () {
                  throw HomePageException(
                      title: 'Error', message: 'Sorry for messing things up.');
                },
                child: const Text('Generate unhandled exception')),
            ElevatedButton(
                onPressed: () async {
                  final myList = [1, 2, 3];
                  final _ = myList[10]; //RangeError
                },
                child: const Text('Generate asynchronous error')),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Page2())),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('RenderFlex Error Page'),
                    Icon(Icons.navigate_next)
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    buildError = true;
                  });
                },
                child: const Text('Rebuild page with error')),
            ElevatedButton(
              onPressed: () {
                try {
                  throw HomePageException(
                      title: 'Handled Error',
                      message:
                          "No worries.  There was an error, but the app didn't break.");
                } on HomePageException catch (e) {
                  AppState().detailedException.value = e;
                  //Fix app state
                }
              },
              child: const Text('Generate and handle error'),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorMessage() async {
    final appState = AppState();
    if (appState.detailedException.value != null) {
      final exception = appState.detailedException.value!;
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                    Text(exception.title),
                  ],
                ),
                content: Text(exception.message),
              ));
      appState.detailedException.value = null;
    }
  }
}
