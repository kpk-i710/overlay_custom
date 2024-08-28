import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String question;
  final Function(String word, LayerLink layerLink) onTapWord;

  ClickableText({
    required this.question,
    required this.onTapWord,
  });

  @override
  Widget build(BuildContext context) {
    final words = question.split(' ');

    return Wrap(
      textDirection: TextDirection.rtl,
      children: words.map((word) {
        final layerLink = LayerLink(); // LayerLink создан для каждого слова
        return GestureDetector(
          onTap: () {
            onTapWord(word, layerLink);
          },
          child: CompositedTransformTarget(
            link: layerLink,
            child: Text(
              '$word ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class MyOverlayExample extends StatefulWidget {
  const MyOverlayExample({Key? key}) : super(key: key);

  @override
  _MyOverlayExampleState createState() => _MyOverlayExampleState();
}

class _MyOverlayExampleState extends State<MyOverlayExample> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(String word, LayerLink layerLink) {
    _overlayEntry?.remove(); // Удаляем предыдущий оверлей перед показом нового
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 100,
        height: 40,
        child: CompositedTransformFollower(
          link: layerLink, // Используем переданный layerLink
          showWhenUnlinked: false,
          offset: const Offset(0, 0), // Смещение оверлея над элементом
          child: Material(
            color: Colors.blue,
            child: Center(
              child: Text(
                'Оверлей',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ClickableText(
          question: 'sdf sdf sdf sdf dsfsd',
          onTapWord: (String word, LayerLink layerLink) {
            _showOverlay(word, layerLink);
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overlay Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Overlay Example')),
        body: const Center(
          child: MyOverlayExample(),
        ),
      ),
    );
  }
}
