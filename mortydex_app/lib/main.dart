import 'package:flutter/material.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_logger/mdx_logger.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Logger.log(message: 'Hello Logger!', type: LogTypes.info);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(HelloWorld.helloWorld),
        ),
      ),
    );
  }
}
