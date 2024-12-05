import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_bloc.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_bloc.dart';
import 'package:tt_34/BLoCs/Weight_bloc/weight_bloc.dart';
import 'package:tt_34/Repo/entry_repo.dart';
import 'package:tt_34/Repo/weight_repo.dart';

import 'BLoCs/Water_Bloc/water_event.dart';
import 'Repo/water_repo.dart';
import 'app.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RecordBloc(RecordRepository())),
        BlocProvider(
          create: (context) {
            final waterBloc = WaterBloc(WaterEntryRepository());
            // Dispatch an event to load today's water entries
            waterBloc.add(LoadWaterEntriesEvent(DateTime.now()));
            return waterBloc;
          },
        ),
        BlocProvider(
          create: (_) => EntryBloc(CurEntryRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
