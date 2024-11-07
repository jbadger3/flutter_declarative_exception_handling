import 'package:flutter/material.dart';

class WidgetErrorPage extends StatefulWidget {
  const WidgetErrorPage({super.key});

  @override
  State<WidgetErrorPage> createState() => _WidgetErrorPageState();
}

class _WidgetErrorPageState extends State<WidgetErrorPage> {
  bool buildError = false;

  @override
  Widget build(BuildContext context) {
    if (buildError) {
      throw Exception('Error rebuilding');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('ErrorWidget Example'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                buildError = true;
              });
            },
            child: const Text('Rebuild page with error')),
      ),
    );
  }
}
