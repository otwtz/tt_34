import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_bloc.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_bloc.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_event.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_state.dart';
import '../../Models/water_model.dart';
import '../../Widgets/gradient_text.dart';
import '../../style.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_event.dart';
import 'package:tt_34/Widgets/listview_of_entries.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  DateTime? currentDate = DateTime.now();
  List<DateTime?> _dates = [];
  int cupsOfWater = 0;
  int? lastSelectedIndex; // Track the last selected index

  List<bool> glasses = List.generate(8, (index) => false);
  int crossIndex = -1;
  int cupsMon = 0;
  int cupsTue = 0;
  int cupsWen = 0;
  int cupsThu = 0;
  int cupsFri = 0;
  int cupsSat = 0;
  int cupsSun = 0;
  int _selectedCups = 0; // Track selected cups

  void _previousDate() {
    setState(() {
      currentDate = currentDate?.subtract(Duration(days: 1));
    });
    context.read<WaterBloc>().add(ChangeDateEvent(-1));
  }

  void _nextDate() {
    setState(() {
      currentDate = currentDate?.add(Duration(days: 1));
    });
    context.read<WaterBloc>().add(ChangeDateEvent(1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WaterBloc, WaterState>(
      listener: (context, state) {
        if (state is WaterEntriesLoadedState)
          for (int i = 0; i < glasses.length; i++) {
            if (i <= state.currentCups) {
              glasses[i] = true;
            } else {
              glasses[i] = false;
            }
          }
      },
      listenWhen: (prev, next) {
        if (prev is WaterEntriesLoadedState && next is WaterEntriesLoadedState) {
          return prev.currentDate != next.currentDate;
        }
        return true;
      },
      builder: (context, state) {
        if (state is WaterLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is WaterEntriesLoadedState) {
          lastSelectedIndex = state.currentCups;
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: Style.pinkGrad,
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 55,
                      ),
                      Text(
                        'Statistic',
                        style: Style.txtStyle.copyWith(fontSize: 24),
                      ),
                      CupertinoButton(
                          child: SvgPicture.asset(
                              'Assets/Icons/lets-icons_calendar-fill.svg'),
                          onPressed: () async {
                            await _selectDate(context);
                          }),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Statistics for the week',
                                style: Style.txtStyle.copyWith(fontSize: 16),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: Style.pinkGrad,
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EasyDateTimeLine(
                                      onDateChange: (date) {
                                        context
                                            .read<WaterBloc>()
                                            .add(LoadWaterEntriesEvent(date));
                                      },
                                      itemBuilder:
                                          (context, date, isSelected, onTap) {
                                        String cupsDate = '';
                                        int cupsConsumed = 0;
                                        DateTime selectedDate = date;
                                        switch (selectedDate.weekday) {
                                          case DateTime.monday:
                                            cupsDate = 'Mon';
                                            break;
                                          case DateTime.tuesday:
                                            cupsDate = 'Tue';
                                            break;
                                          case DateTime.wednesday:
                                            cupsDate = 'Wed';
                                            break;
                                          case DateTime.thursday:
                                            cupsDate = 'Thu';
                                            break;
                                          case DateTime.friday:
                                            cupsDate = 'Fri';
                                            break;
                                          case DateTime.saturday:
                                            cupsDate = 'Sat';
                                            break;
                                          case DateTime.sunday:
                                            cupsDate = 'Sun';
                                            break;
                                        }

                                        cupsConsumed = state.entries
                                            .where((entry) =>
                                                DateTime.parse(entry.date
                                                        .toIso8601String())
                                                    .weekday ==
                                                selectedDate.weekday)
                                            .fold(
                                                0,
                                                (sum, entry) =>
                                                    sum + entry.amount);

                                        double percent =
                                            (cupsConsumed / 8).clamp(0.0, 1.0);
                                        return Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 5),
                                                child: CircularPercentIndicator(
                                                  radius: 20.0,
                                                  lineWidth: 2.0,
                                                  percent: percent,
                                                  center: Text(
                                                    cupsDate,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                  progressColor: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  '${(cupsConsumed) * 250 / 1000} L',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      initialDate: currentDate!,
                                      headerProps: EasyHeaderProps(
                                        showHeader: false,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Drinks for the week',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          '${(state.currentCups + 1) * 250 / 1000} L',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CupertinoButton(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: _previousDate,
                                  ),
                                  Text(
                                    DateFormat('dd.MM.yyyy')
                                        .format(currentDate!),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Container(
                                width: double.infinity,
                                height: 229,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(41, 43, 72, 1),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(4, (index) {
                                        return _buildGlass(index);
                                      }),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(4, (index) {
                                        return _buildGlass(index + 4);
                                      }),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${(state.currentCups + 1) * 250 / 1000} L',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 60,
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is WaterErrorState) {
          return Center(child: Text(state.message));
        }
        return Center(
            child: Text('Select a date to start tracking water intake.'));
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      dialogBackgroundColor: Style.darkBlue,
      config: CalendarDatePicker2WithActionButtonsConfig(
        lastMonthIcon: Icon(
          Icons.arrow_back_ios,
          color: Color.fromRGBO(255, 150, 188, 1),
        ),
        nextMonthIcon: Icon(
          Icons.arrow_forward_ios,
          color: Color.fromRGBO(255, 150, 188, 1),
        ),
        controlsTextStyle: TextStyle(
          color: Color.fromRGBO(255, 150, 188, 1),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        centerAlignModePicker: true,
        todayTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        weekdayLabelTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        selectedMonthTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        dayTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        selectedDayHighlightColor: Style.darkBlue,
        yearTextStyle: TextStyle(
          color: Color.fromRGBO(255, 150, 188, 1),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        monthTextStyle: TextStyle(
          color: Color.fromRGBO(255, 150, 188, 1),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        calendarType: CalendarDatePicker2Type.single,
        cancelButton: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 82,
            height: 42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: Color.fromRGBO(255, 150, 188, 1),
                )),
            child: Center(
              child: GradientText(
                'Cancel',
                style: Style.txtStyle.copyWith(
                  fontSize: 16,
                ),
                colors: Style.pinkGrad,
              ),
            ),
          ),
        ),
        okButton: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (_dates.isNotEmpty) {
              setState(() {
                currentDate = _dates.first;
              });
              // context
              //     .read<RecordBloc>()
              //     .add(GetRecordsByDateEvent(selectedDate!));
            }
            Navigator.pop(context);
          },
          child: Container(
            width: 82,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: Style.pinkGrad),
            ),
            child: Center(
              child: Text(
                'Save',
                style: Style.txtStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      dialogSize: const Size(357, 450),
      value: _dates,
      borderRadius: BorderRadius.circular(15),
    );

    if (results != null && results.isNotEmpty) {
      setState(() {
        _dates = results;
        currentDate = _dates.first!;
      });
    }
  }

  Widget _buildGlass(int index) {
    return CupertinoButton(
      onPressed: () {
        setState(() {
          if (lastSelectedIndex == null || index == lastSelectedIndex! + 1) {
            glasses[index] = !glasses[index];
            if (glasses[index]) {
              context
                  .read<WaterBloc>()
                  .add(AddWaterEntryEvent(1));
              lastSelectedIndex = index;
            } else {
              context
                  .read<WaterBloc>()
                  .add(ResetWaterEntryEvent());
            }
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'Assets/Icons/mdi_glass.svg',
              color:
                  glasses[index] ? Colors.pink : Colors.pink.withOpacity(0.5),
            ),
            if (!glasses[index])
              Positioned(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _resetCups() {
    setState(() {
      _selectedCups = 0; // Reset selected cups
    });
    context.read<WaterBloc>().add(ResetWaterEntryEvent()); // Reset in BLoC
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentState = context.read<WaterBloc>().state;
    if (currentState is WaterEntriesLoadedState) {
      if (currentState.currentDate != DateTime.now()) {
        _resetCups();
      }
    }
  }
}
