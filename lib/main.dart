import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final imageData = await rootBundle.load('asset/flash.webp');
  final image = await decodeImageFromList(Uint8List.sublistView(imageData));

  runApp(
    Builder(
      builder: (context) {
        return Center(
          child: CustomPaint(
            painter: _Painter(image),
            size: const Size(200, 200),
          ),
        );
      },
    ),
  );
}

class _Painter extends CustomPainter {
  _Painter(this.image);

  final ui.Image image;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Offset.zero & size / 4,
      // Works as expected
      // Paint()..blendMode = BlendMode.srcOver,
      // Nothing is drawn or with other sizes some
      Paint()..blendMode = BlendMode.screen,
    );
  }
}
