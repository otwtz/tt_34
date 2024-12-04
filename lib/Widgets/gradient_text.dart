import 'package:flutter/material.dart';

import '../style.dart';

class GradientText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final List<Color> colors;

  GradientText(this.text, {required this.style, required this.colors});

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: widget.colors,
        tileMode: TileMode.clamp,
      ).createShader(bounds),
      child: Text(
        widget.text,
        style: widget.style.copyWith(color: Colors.white),
      ),
    );
  }
}
