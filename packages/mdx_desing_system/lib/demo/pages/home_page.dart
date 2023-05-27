import 'package:flutter/material.dart';
import 'package:mdx_desing_system/demo/pages/basics_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MDX Desing System'),
      ),
      body: const SafeArea(
        child: PrimaryActions(),
      ),
    );
  }
}

class PrimaryActions extends StatelessWidget {
  const PrimaryActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BasicsPage()),
              );
            },
            child: const Text('Basics'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Atoms'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Molecules'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Organims'),
          ),
        ],
      ),
    );
  }
}
