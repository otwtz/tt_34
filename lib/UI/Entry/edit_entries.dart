import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_bloc.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_event.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_state.dart';
import 'package:tt_34/UI/Entry/day_and_entries.dart';
import 'package:tt_34/UI/Others/home.dart';
import 'package:tt_34/Widgets/bottom_navigation_bar.dart';

import '../../Models/entry_model.dart';
import '../../style.dart';

class EntryEditScreen extends StatefulWidget {
  final Entry entry;

  const EntryEditScreen({super.key, required this.entry});

  @override
  State<EntryEditScreen> createState() => _EntryEditScreenState();
}

class _EntryEditScreenState extends State<EntryEditScreen> {
  late final TextEditingController _entryEditingController;

  @override
  void initState() {
    _entryEditingController = TextEditingController(text: widget.entry.content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecordBloc, RecordState>(
        builder: (context,state ) {
          return Container(
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
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Edit entry',
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
                                            .format(state.currentDateTime!),
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
                                  decoration: InputDecoration(
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
                          onPressed: () {
                            context
                                .read<RecordBloc>()
                                .add(AddRecordEvent(widget.entry.copyWith(
                              content: _entryEditingController.text.isNotEmpty ? _entryEditingController.text : widget.entry.content,
                            )));
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (context) => ChangeBodies(index: 0,
                                )),
                                  (Route<dynamic> route) => false,);
                          },
                          child: Container(
                            width: 186,
                            height: 59,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Style.blueGrad,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Save',
                                style: Style.txtStyle.copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
