import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_bloc.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_bloc.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_event.dart';
import 'package:tt_34/BLoCs/Water_Bloc/water_state.dart';
import 'package:tt_34/Models/water_model.dart';
import 'package:tt_34/UI/Water/date_of_week.dart';
import '../../Widgets/gradient_text.dart';
import '../../style.dart';
import 'package:intl/intl.dart';

class WaterControlScreen extends StatefulWidget {
  const WaterControlScreen({super.key});

  @override
  State<WaterControlScreen> createState() => _WaterControlScreenState();
}

class _WaterControlScreenState extends State<WaterControlScreen> {
  int cupsMon = 0;
  int cupsTue = 0;
  int cupsWen = 0;
  int cupsThu = 0;
  int cupsFri = 0;
  int cupsSat = 0;
  int cupsSun = 0;

  int cupsOfWater = 0;
  List<bool> glasses = List.generate(8, (index) => false);
  int crossIndex = -1;
  Map<DateTime, double> waterConsumption = {};

  void _toggleGlass(int index) {
    setState(() {
      for (int i = 0; i < glasses.length; i++) {
        if (i <= index) {
          if (!glasses[i]) {
            // Increment the cup count for the current day
            switch (DateTime
                .now()
                .weekday) {
              case DateTime.monday:
                cupsMon++;
                break;
              case DateTime.tuesday:
                cupsTue++;
                break;
              case DateTime.wednesday:
                cupsWen++;
                break;
              case DateTime.thursday:
                cupsThu++;
                break;
              case DateTime.friday:
                cupsFri++;
                break;
              case DateTime.saturday:
                cupsSat++;
                break;
              case DateTime.sunday:
                cupsSun++;
                break;
            }
          }
          glasses[i] = true; // Mark the glass as filled
        } else {
          glasses[i] = false; // Reset glasses above the selected index
        }
      }
      crossIndex = index;
    });

    final totalGlasses = index + 1;
    final entry = WaterEntry(
      date: _currentDate,
      amount: totalGlasses * 0.25,
    );
    context.read<WaterBloc>().add(AddWaterEntryEvent(entry));
  }

  @override
  void initState() {
    super.initState();
    // context.read<WaterBloc>().add(LoadWaterEntriesEvent(_currentDate));
  }

  List<DateTime?> _dates = [];
  DateTime _currentDate = DateTime.now();

  void _previousDate() {
    setState(() {
      _currentDate = _currentDate.subtract(Duration(days: 1));
    });
    context.read<WaterBloc>().add(LoadWaterEntriesEvent(_currentDate));
  }

  void _nextDate() {
    setState(() {
      _currentDate = _currentDate.add(Duration(days: 1));
    });
    context.read<WaterBloc>().add(LoadWaterEntriesEvent(_currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<WaterBloc, WaterState>(builder: (context, state) {
          double cupsMon = 0,
              cupsTue = 0,
              cupsWen = 0,
              cupsThu = 0,
              cupsFri = 0,
              cupsSat = 0,
              cupsSun = 0;
          if (state is WaterInitialState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WaterEntriesLoadedState) {
            for (var entry in state.entries) {
              switch (entry.date.weekday) {
                case DateTime.monday:
                  cupsMon += entry.amount;
                  break;
                case DateTime.tuesday:
                  cupsTue += entry.amount;
                  break;
                case DateTime.wednesday:
                  cupsWen += entry.amount;
                  break;
                case DateTime.thursday:
                  cupsThu += entry.amount;
                  break;
                case DateTime.friday:
                  cupsFri += entry.amount;
                  break;
                case DateTime.saturday:
                  cupsSat += entry.amount;
                  break;
                case DateTime.sunday:
                  cupsSun += entry.amount;
                  break;
              }
            }
          return Container(
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
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Statistics for the week',
                                style: Style.txtStyle.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              width: double.infinity,
                              height: 151,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: Style.pinkGrad,
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      WaterConsumptionWidget(
                                          dayName: 'Monday',
                                          amountConsumed: cupsMon),
                                      WaterConsumptionWidget(
                                          dayName: 'Tuesday',
                                          amountConsumed: cupsTue),
                                      WaterConsumptionWidget(
                                          dayName: 'Wednesday',
                                          amountConsumed: cupsWen),
                                      WaterConsumptionWidget(
                                          dayName: 'Thursday',
                                          amountConsumed: cupsThu),
                                      WaterConsumptionWidget(
                                          dayName: 'Friday',
                                          amountConsumed: cupsFri),
                                      WaterConsumptionWidget(
                                          dayName: 'Saturday',
                                          amountConsumed: cupsSat),
                                      WaterConsumptionWidget(
                                          dayName: 'Sunday',
                                          amountConsumed: cupsSun),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //   MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(height: 12),
                                  //         CircularPercentIndicator(
                                  //           radius: 20.0,
                                  //           lineWidth: 3.0,
                                  //           percent: (cupsMon * 250 / 1000) / 2,
                                  //           center: Text(
                                  //             'M',
                                  //             style: TextStyle(
                                  //                 color: Colors.white),
                                  //           ),
                                  //           progressColor: Color.fromRGBO(
                                  //               255, 255, 255, 1),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 6,
                                  //         ),
                                  //         Text(
                                  //           '${cupsMon * 250 / 1000} L',
                                  //           style:
                                  //           TextStyle(color: Colors.white),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(height: 12),
                                  //         CircularPercentIndicator(
                                  //           radius: 20.0,
                                  //           lineWidth: 3.0,
                                  //           percent: (cupsTue * 250 / 1000) / 2,
                                  //           center: Text(
                                  //             'Tu',
                                  //             style: TextStyle(
                                  //                 color: Colors.white),
                                  //           ),
                                  //           progressColor: Color.fromRGBO(
                                  //               255, 255, 255, 1),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 6,
                                  //         ),
                                  //         Text(
                                  //           '${cupsTue * 250 / 1000} L',
                                  //           style:
                                  //           TextStyle(color: Colors.white),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(height: 12),
                                  //         CircularPercentIndicator(
                                  //           radius: 20.0,
                                  //           lineWidth: 3.0,
                                  //           percent: (cupsWen * 250 / 1000) / 2,
                                  //           center: Text(
                                  //             'Wen',
                                  //             style: TextStyle(
                                  //                 color: Colors.white),
                                  //           ),
                                  //           progressColor: Color.fromRGBO(
                                  //               255, 255, 255, 1),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 6,
                                  //         ),
                                  //         Text(
                                  //           '${cupsWen * 250 / 1000} L',
                                  //           style:
                                  //           TextStyle(color: Colors.white),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(height: 12),
                                  //         CircularPercentIndicator(
                                  //           radius: 20.0,
                                  //           lineWidth: 3.0,
                                  //           percent: (cupsThu * 250 / 1000) / 2,
                                  //           center: Text(
                                  //             'Thu',
                                  //             style: TextStyle(
                                  //                 color: Colors.white),
                                  //           ),
                                  //           progressColor: Color.fromRGBO(
                                  //               255, 255, 255, 1),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 6,
                                  //         ),
                                  //         Text(
                                  //           '${cupsThu * 250 / 1000} L',
                                  //           style:
                                  //           TextStyle(color: Colors.white),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(height: 12),
                                  //         CircularPercentIndicator(
                                  //           radius: 20.0,
                                  //           lineWidth: 3.0,
                                  //           percent: (cupsFri * 250 / 1000) / 2,
                                  //           center: Text(
                                  //             'Fri',
                                  //             style: TextStyle(
                                  //                 color: Colors.white),
                                  //           ),
                                  //           progressColor: Color.fromRGBO(
                                  //               255, 255, 255, 1),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 6,
                                  //         ),
                                  //         Text(
                                  //           '${cupsFri * 250 / 1000} L',
                                  //           style:
                                  //           TextStyle(color: Colors.white),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(height: 12),
                                  //         CircularPercentIndicator(
                                  //           radius: 20.0,
                                  //           lineWidth: 3.0,
                                  //           percent: (cupsSat * 250 / 1000) / 2,
                                  //           center: Text(
                                  //             'Sat',
                                  //             style: TextStyle(
                                  //                 color: Colors.white),
                                  //           ),
                                  //           progressColor: Color.fromRGBO(
                                  //               255, 255, 255, 1),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 6,
                                  //         ),
                                  //         Text(
                                  //           '${cupsSat * 250 / 1000} L',
                                  //           style:
                                  //           TextStyle(color: Colors.white),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(height: 12),
                                  //         CircularPercentIndicator(
                                  //           radius: 20.0,
                                  //           lineWidth: 3.0,
                                  //           percent: (cupsSun * 250 / 1000) / 2,
                                  //           center: Text(
                                  //             'Sun',
                                  //             style: TextStyle(
                                  //                 color: Colors.white),
                                  //           ),
                                  //           progressColor: Color.fromRGBO(
                                  //               255, 255, 255, 1),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 6,
                                  //         ),
                                  //         Text(
                                  //           '${cupsSun * 250 / 1000} L',
                                  //           style:
                                  //           TextStyle(color: Colors.white),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 60,
                                                width: 10,
                                              ),
                                              Text(
                                                'Drinks for the week',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 60,
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsets.only(right: 10),
                                                child: Text(
                                                  '${(cupsMon + cupsTue +
                                                      cupsWen + cupsThu +
                                                      cupsFri + cupsSat +
                                                      cupsSun) * 250} ml',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     Text(
                                  //       '${(cupsMon + cupsTue + cupsWen +
                                  //           cupsThu + cupsFri + cupsSat +
                                  //           cupsSun) * 250} ML',
                                  //       style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 24,
                                  //           fontWeight: FontWeight.w400),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 60,
                                  //       width: 20,
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
            else if (state is WaterErrorState) {
    return Center(child: Text(state.message));
    }
        return Center(child: Text('No entries found.'));

  }

  )

  ,

  );
}

Widget _buildGlass(int index) {
  return CupertinoButton(
    onPressed: () => _toggleGlass(index),
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
          _currentDate = _dates.first!;
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
      _currentDate = _dates.first!;
    });
  }
}}
