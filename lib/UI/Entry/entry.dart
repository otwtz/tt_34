import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_bloc.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_event.dart';
import 'package:tt_34/Models/entry_model.dart';

import '../../Widgets/gradient_text.dart';
import '../../style.dart';
import 'day_and_entries.dart';

class EntryControlScreen extends StatefulWidget {
  const EntryControlScreen({super.key});

  @override
  State<EntryControlScreen> createState() => _EntryControlScreenState();
}

class _EntryControlScreenState extends State<EntryControlScreen> {
  bool _isButtonEnabled = false;

  final TextEditingController _entryEditingController = TextEditingController();

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _entryEditingController.text.isNotEmpty;
    });
  }

  Future<void> _addTask(BuildContext context) async {
    final title = _entryEditingController.text;
    if (_isButtonEnabled) {
      final entry = Entry(content: title, date: DateTime.now());
      context.read<RecordBloc>().add(AddRecordEvent(entry));
      context.read<RecordBloc>().add(GetRecordsByDateEvent(DateTime.now()));
      await Future.delayed(Duration(milliseconds: 100));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DayAndEntries(),
        ),
      );
      _entryEditingController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните все поля корректно.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Style.blueGrad,
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CupertinoButton(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context
                            .read<RecordBloc>()
                            .add(GetRecordsByDateEvent(DateTime.now()));
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'New entry',
                      style: Style.txtStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Style.bgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                    DateFormat('dd.MM.yyyy')
                                        .format(DateTime.now()),
                                    style: Style.txtStyle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: TextField(
                              controller: _entryEditingController,
                              onChanged: (value) => _updateButtonState(),
                              decoration: InputDecoration(
                                hintText:
                                    'What happened to you during the day? Describe a\nsituation that caused positive or negative emotions',
                                hintStyle: Style.txtStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                              style: Style.txtStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              expands: true,
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Positioned(
                  bottom: 40,
                  child: CupertinoButton(
                    onPressed: _entryEditingController.text.isNotEmpty
                        ? () => _addTask(context)
                        : null,
                    child: Opacity(
                      opacity:
                      _isButtonEnabled ? 1.0 : 0.5,
                      child: Container(
                        width: 186,
                        height: 59,
                        decoration: BoxDecoration(
                          gradient: _isButtonEnabled
                              ? LinearGradient(
                                  colors: Style
                                      .blueGrad)
                              : LinearGradient(
                                  colors: [Colors.grey, Colors.grey]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: Style.txtStyle.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
