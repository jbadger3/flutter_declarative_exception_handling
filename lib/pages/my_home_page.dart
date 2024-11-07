import 'package:flutter/material.dart';

import 'package:flutter_declarative_exception_handling/app_state.dart';
import 'package:flutter_declarative_exception_handling/pages/async_error_example_page.dart';
import 'package:flutter_declarative_exception_handling/pages/flutter_error_examples_page.dart';
import 'package:flutter_declarative_exception_handling/pages/widget_error_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: const Text('1. ErrorWidget Example'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WidgetErrorPage())),
            ),
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FlutterErrorExamplesPage())),
              title: const Text('2. FlutterError Examples'),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AsyncErrorExamplePage())),
              title: const Text('3. Async Error Example'),
              trailing: const Icon(Icons.navigate_next),
            )
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
