import 'package:flutter/material.dart';
import 'dart:ui';

class CustomPopupMenu extends StatefulWidget {
  const CustomPopupMenu({
    Key? key,
    required this.child,
    required this.menuContent,
    this.offset = const Offset(0, 0),
  }) : super(key: key);

  final Widget child;
  final Widget menuContent;
  final Offset offset;

  @override
  _CustomPopupMenuState createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _showMenu,
      child: widget.child,
    );
  }

  void _showMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      return;
    }

    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset widgetOffset = renderBox.localToGlobal(Offset.zero);
    final Size widgetSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: _closeMenu,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Полупрозрачный фон
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              top: widgetOffset.dy + widgetSize.height + widget.offset.dy,
              left: widgetOffset.dx + widget.offset.dx,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    // Оставляем функциональность для закрытия меню
                    _closeMenu();
                  },
                  child: widget.menuContent,
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
