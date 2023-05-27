import 'package:flutter/material.dart';
import 'package:mdx_desing_system/mdx_desing_system.dart';

class ProtonsPage extends StatelessWidget {
  const ProtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protons'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: MDXColorsView(),
        ),
      ),
    );
  }
}

class MDXColorsView extends StatelessWidget {
  const MDXColorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MDXColors.primary',
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ColorWidget(
              name: 'MDXColors.primary.p1',
              color: MDXColors.primary.p1,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'MDXColors.secondary',
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ColorWidget(
              name: 'MDXColors.secondary.s1',
              color: MDXColors.secondary.s1,
            ),
            ColorWidget(
              name: 'MDXColors.secondary.s2',
              color: MDXColors.secondary.s2,
            ),
            ColorWidget(
              name: 'MDXColors.secondary.s3',
              color: MDXColors.secondary.s3,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'MDXColors.status',
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ColorWidget(
              name: 'MDXColors.status.s1',
              color: MDXColors.status.s1,
            ),
            ColorWidget(
              name: 'MDXColors.status.s2',
              color: MDXColors.status.s2,
            ),
            ColorWidget(
              name: 'MDXColors.status.s3',
              color: MDXColors.status.s3,
            ),
            ColorWidget(
              name: 'MDXColors.status.s4',
              color: MDXColors.status.s4,
            ),
          ],
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  final String name;
  final Color color;
  const ColorWidget({
    super.key,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name),
        const SizedBox(
          width: 16.0,
        ),
        Container(
          color: color,
          child: const SizedBox(
            width: 100.0,
            height: 50.0,
          ),
        ),
      ],
    );
  }
}
