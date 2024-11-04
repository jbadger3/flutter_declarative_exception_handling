import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_declarative_exception_handling/pages/my_home_page.dart';

void main() {
  //1.  Uncaught errors while building widgets
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    if (kDebugMode) {
      FlutterError.presentError(errorDetails);
    }
    if (kReleaseMode) {
      // report to crash log service

      exit(1); //terminate the app
    }

    return ErrorWidget(errorDetails.exception);
  };

  //2. Uncaught errors reported by the Flutter Framework
  FlutterError.onError = (FlutterErrorDetails errorDetails) {
    if (kDebugMode) {
      debugPrint('Flutter framework encountered an uncaught error');
      FlutterError.presentError(errorDetails);
    }

    if (kReleaseMode) {
      // report to crash log service

      if (errorDetails.exception is Error) {
        exit(1); //terminate the app
      }
    }
  };

  //3. Uncaught asynchronous errors
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      debugPrint('Encountered an uncaught asyncrhonous error');
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stack);
    }
    if (kReleaseMode) {
      // report to crash log service
      exit(1); //terminate the app
    }

    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exception Handling Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Exception Handling Demo'),
    );
  }
}
