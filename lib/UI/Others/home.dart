import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_bloc.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_state.dart';
import 'package:tt_34/UI/WEight/weight.dart';
import 'package:tt_34/UI/Water/water.dart';
import 'package:tt_34/Widgets/bottom_navigation_bar.dart';
import 'package:tt_34/style.dart';
import '../../BLoCs/Entry_bloc/entry_event.dart';
import '../../Widgets/listview_of_entries.dart';
import '../Entry/entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _currentDate = DateTime.now();

  void _previousDate() {
    setState(() {
      _currentDate = _currentDate.subtract(Duration(days: 1));
    });
    context.read<RecordBloc>().add(GetRecordsByDateEvent(_currentDate));
  }

  void _nextDate() {
    setState(() {
      _currentDate = _currentDate.add(Duration(days: 1));
    });
    context.read<RecordBloc>().add(GetRecordsByDateEvent(_currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      body: BlocBuilder<RecordBloc, RecordState>(builder: (context, state) {
        context.read<RecordBloc>().add(LoadRecordEvent());
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                'Hi!',
                style: Style.txtStyle.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 176,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: Style.blueGrad),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'A diary of automatic thoughts',
                            style: Style.txtStyle.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Work through the situations',
                            style: Style.txtStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: CupertinoButton(
                        child: Container(
                          width: 141,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'Assets/Icons/iconamoon_edit-bold.svg'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'New entry',
                                  style: Style.txtStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(60, 169, 236, 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EntryControlScreen(),
                          ));
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 5,
                      child: Image.asset(
                          'Assets/Icons/7509c131-0caf-4b5f-b735-5c0948df6e0e 1.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 155,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: Style.pinkGrad),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Water dynamics',
                                  style: Style.txtStyle.copyWith(fontSize: 16),
                                ),
                                Text(
                                  'Watch how much\nyou drink',
                                  style: Style.txtStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: CupertinoButton(
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 14,
                                )),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChangeBodies(index: 2),
                                ));
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Image.asset(
                                'Assets/Icons/7abd06e2-9a54-4065-a16f-4276877b3807 1.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 155,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: Style.purpleGrad),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Weight dynamics',
                                  style: Style.txtStyle.copyWith(fontSize: 16),
                                ),
                                Text(
                                  'Keep track of your\nweight trends',
                                  style: Style.txtStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: CupertinoButton(
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 14,
                                )),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChangeBodies(index: 1),
                                ));
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Image.asset(
                                'Assets/Icons/DeWatermark.ai_1731665366511-Photoroom 1.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: _previousDate,
                    ),
                    Text(
                      DateFormat('dd.MM.yyyy').format(_currentDate),
                      style: Style.txtStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    CupertinoButton(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                      onPressed: _nextDate,
                    ),
                  ],
                ),
              ),
              state.currentEntryByDate.isNotEmpty
                  ? Expanded(
                      child: EntryListScreen(entries: state.currentEntryByDate),
                    )
                  : Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                'This is where your records\nwill be kept',
                                style: Style.txtStyle.copyWith(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
