import 'package:flutter/material.dart';
import 'package:mdx_desing_system/demo/pages/protons_page.dart';

class BasicsPage extends StatelessWidget {
  const BasicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basics'),
      ),
      body: const SafeArea(
        child: BasicsActions(),
      ),
    );
  }
}

class BasicsActions extends StatelessWidget {
  const BasicsActions({super.key});

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
                MaterialPageRoute(builder: (context) => const ProtonsPage()),
              );
            },
            child: const Text('Protons'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Electrons'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Neutrons'),
          ),
        ],
      ),
    );
  }
}
