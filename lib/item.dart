import 'package:flutter/material.dart';
import 'package:stackouside/arrow.dart';
import 'package:stackouside/visit.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClickableText(
          question: 'sfasdf sdfsdf sdffsad',
          onTapWord: (String text, Offset globalPosition, Size size) {}),
    );
  }
}
