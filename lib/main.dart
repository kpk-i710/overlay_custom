import 'package:flutter/material.dart';

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

class MyOverlayExample extends StatefulWidget {
  const MyOverlayExample({Key? key}) : super(key: key);

  @override
  _MyOverlayExampleState createState() => _MyOverlayExampleState();
}

class _MyOverlayExampleState extends State<MyOverlayExample> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(LayerLink layerLink) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 100,
        height: 40,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, -50), // Смещение оверлея над элементом
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
        for (int i = 0; i < 10; i++)
          Builder(
            builder: (context) {
              final layerLink = LayerLink();
              return CompositedTransformTarget(
                link: layerLink,
                child: GestureDetector(
                  onTap: () {
                    _showOverlay(layerLink);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Элемент $i'),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
