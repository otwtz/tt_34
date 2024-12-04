import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_state.dart';
import 'package:tt_34/UI/Entry/edit_entries.dart';
import 'package:tt_34/style.dart';

import '../BLoCs/Entry_bloc/entry_bloc.dart';
import '../Models/entry_model.dart';

class EntryListScreen extends StatelessWidget {
  final List<Entry> entries;

  EntryListScreen({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.records.isEmpty) {
          return Center(child: Text('Нет записей'));
        }
        return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EntryEditScreen(entry: entry,),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Style.darkBlue
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        maxLines: 3,
                        entry.content,
                        style: Style.txtStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis, // Обрезка текста с троеточием
                      ),
                    ),
                  ),
                ),
              );
            },
          );
      }
    );
  }
}
