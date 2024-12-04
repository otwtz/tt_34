import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../style.dart';

class TextScreen extends StatelessWidget {
  final String title;
  final String description;

  TextScreen({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        leading: CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 21,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: Style.txtAppBars,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Markdown(
          data: description,
          styleSheet: MarkdownStyleSheet(
            h1: Style.txtStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            h2: Style.txtStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            h3: Style.txtStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            p: Style.txtStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
