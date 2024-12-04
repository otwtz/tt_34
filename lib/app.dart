import 'package:flutter/material.dart';
import 'package:tt_34/UI/Entry/entry.dart';
import 'package:tt_34/UI/Others/settings.dart';
import 'package:tt_34/UI/WEight/weight.dart';
import 'package:tt_34/Widgets/bottom_navigation_bar.dart';
import 'UI/Entry/day_and_entries.dart';
import 'UI/Others/onboarding.dart';
import 'UI/Water/water.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeBodies(
        index: 0,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
