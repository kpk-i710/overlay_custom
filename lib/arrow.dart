import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stackouside/visit.dart';

class ClickableText extends StatelessWidget {
  final String question;
  final Function(String word, Offset globalPosition, Size size) onTapWord;

  ClickableText({required this.question, required this.onTapWord});

  @override
  Widget build(BuildContext context) {
    final words = question.split(' ');

    return Wrap(
      textDirection: TextDirection.rtl,
      children: words.map((word) {
        return CustomPopupMenu(
          menuContent: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.green,
                child: const Text(
                  'Custom Widget 2',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          child: WordWidget(
            word: word,
            onTapWord: onTapWord,
          ),
        );
      }).toList(),
    );
  }
}

class WordWidget extends StatefulWidget {
  final String word;
  final Function(String word, Offset globalPosition, Size size) onTapWord;

  WordWidget({required this.word, required this.onTapWord});

  @override
  _WordWidgetState createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  void _onTap() {}

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.word} ',
      style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dotted),
    );
  }
}
