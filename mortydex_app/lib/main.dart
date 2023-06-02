import 'package:flutter/material.dart';
// import 'package:mdx_core/mdx_core.dart';

void configureDependencies() {
  // core.configureDependencies(resolverDI);
}

void main() {
  configureDependencies();
  return runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('HelloWorld'),
        ),
      ),
    );
  }
}

abstract interface class TextClassProtocol {
  String text;
  TextClassProtocol(this.text);
  String hola();
}

class TextClassImp implements TextClassProtocol {
  @override
  String text;

  TextClassImp(this.text);

  @override
  String hola() => text;
}
