import 'package:flutter/material.dart';
import 'package:stackouside/item.dart';
import 'package:stackouside/visit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Popup Menu Example')),
        body: const Center(
          child: CustomPopupExample(),
        ),
      ),
    );
  }
}

class CustomPopupExample extends StatelessWidget {
  const CustomPopupExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ClickableText(
          question: 'sdf sdf sdf',
          onTapWord: (String word, Offset globalPosition, Size size) {},
        ),
        ClickableText(
          question: 'sdf sdf sdf',
          onTapWord: (String word, Offset globalPosition, Size size) {},
        ),
      ],
    );
  }
}
