import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt_34/BLoCs/Weight_bloc/weight_event.dart';
import 'package:tt_34/BLoCs/Weight_bloc/weight_state.dart';

import '../../BLoCs/Weight_bloc/weight_bloc.dart';
import '../../Models/weight_model.dart';
import '../../Widgets/gradient_text.dart';
import '../../style.dart';

class WeightControlScreen extends StatefulWidget {
  const WeightControlScreen({super.key});

  @override
  State<WeightControlScreen> createState() => _WeightControlScreenState();
}

class _WeightControlScreenState extends State<WeightControlScreen> {
  List<DateTime?> _dates = [];

  final TextEditingController _startWeightController = TextEditingController();
  final TextEditingController _goalWeightController = TextEditingController();
  final TextEditingController _currentWeightController =
      TextEditingController();

  DateTime? _currentDate = DateTime.now();

  List<double> _weightData = [];
  List<DateTime> _weightDates = [];

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _loadWeights();
  }

  // double? startWeight;
  String _goalWeightString = '0 кг';
  int _goalWeight = 0;
  int _startWeight = 0;
  String _startWeightString = '0 кг';
  String _currentWeightString = '0 кг';

  Future<void> _loadWeights() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? weights = prefs.getStringList('weights');
    List<String>? dates = prefs.getStringList('dates');

    print(_goalWeightString);
    if (weights != null && dates != null) {
      setState(() {
        _goalWeightString = '${prefs.getDouble('goalWeight') ?? 0} кг';
        _startWeightString = '${prefs.getDouble('startWeight') ?? 0} кг';
        _currentWeightString = '${prefs.getDouble('currentWeight') ?? 0} кг';
        _goalWeight = prefs.getDouble('goalWeight')?.toInt() ?? 0;
        _startWeight = prefs.getDouble('startWeight')?.toInt() ?? 0;
        _weightData = weights.map((e) => double.parse(e)).toList();
        _weightDates = dates.map((e) => DateTime.parse(e)).toList();
      });
    } else {
      setState(() {
        _goalWeightString = '${prefs.getDouble('goalWeight') ?? 0} кг';
        _startWeightString = '${prefs.getDouble('startWeight') ?? 0} кг';
        _currentWeightString = prefs.getString('currentWeight') ?? '0 кг';
      });
    }
    // _goalWeightString = prefs.getString('goalWeight') ?? '0 кг';
    _goalWeight = int.tryParse(_goalWeightString.replaceAll(' кг', '')) ?? 0;
  }

  Future<void> _saveWeight(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await _saveInPrefs(key, value);

    setState(() {
      _weightData.add(value.toDouble());
      _weightDates.add(_currentDate!);
    });
    await prefs.setStringList(
        'weights', _weightData.map((e) => e.toString()).toList());
    await prefs.setStringList(
        'dates', _weightDates.map((e) => e.toIso8601String()).toList());
  }

  Future<void> _replaceCurrent(double value) async {
    final prefs = await SharedPreferences.getInstance();
    _weightData[0] = value;
    await prefs.setStringList(
        'weights', _weightData.map((e) => e.toString()).toList());
    setState(() {});
  }

  Future<void> _saveInPrefs(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
    setState(() {});
  }

  void _previousDate() {
    setState(() {
      _currentDate = _currentDate?.subtract(Duration(days: 1));
    });
  }

  void _nextDate() {
    setState(() {
      _currentDate = _currentDate?.add(Duration(days: 1));
      // _currentDate?.weekday == DateTime.monday;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<EntryBloc, EntryState>(builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: Style.purpleGrad,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weight',
                      style: Style.txtStyle.copyWith(fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        'Goal',
                                        style: Style.txtStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    GradientText(
                                      _goalWeightString,
                                      style: Style.txtStyle.copyWith(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      colors: Style.purpleGrad,
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                                Positioned(
                                  right: 75,
                                  top: -18,
                                  child: CupertinoButton(
                                    onPressed: () {
                                      _showWeightDialog(
                                        _goalWeightController,
                                        'Goal',
                                        'goalWeight',
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      'Assets/Icons/iconamoon_edit-bold (1).svg',
                                      width: 20,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 74,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Style.darkBlue,
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Weight at startup:',
                                                  style:
                                                      Style.txtStyle.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                GradientText(
                                                  _startWeightString,
                                                  style:
                                                      Style.txtStyle.copyWith(
                                                    fontSize: 16,
                                                  ),
                                                  colors: Style.purpleGrad,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: -10,
                                            child: CupertinoButton(
                                              onPressed: () {
                                                _showWeightDialog(
                                                  _startWeightController,
                                                  'Weight at startup:',
                                                  'startWeight',
                                                );
                                              },
                                              child: SvgPicture.asset(
                                                'Assets/Icons/iconamoon_edit-bold (1).svg',
                                                width: 20,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                            ),
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
                                      height: 74,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Style.darkBlue,
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Current weight:',
                                                  style:
                                                      Style.txtStyle.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                GradientText(
                                                  _currentWeightString,
                                                  style:
                                                      Style.txtStyle.copyWith(
                                                    fontSize: 16,
                                                  ),
                                                  colors: Style.purpleGrad,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: -10,
                                            child: CupertinoButton(
                                              onPressed: () {
                                                _showWeightDialog(
                                                  _currentWeightController,
                                                  'Current weight:',
                                                  'currentWeight',
                                                );
                                              },
                                              child: SvgPicture.asset(
                                                'Assets/Icons/iconamoon_edit-bold (1).svg',
                                                width: 20,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CupertinoButton(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'Assets/Icons/Group (1).svg'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        DateFormat('MMMM yyyy')
                                            .format(_currentDate!),
                                        // Форматирование текущей даты
                                        style: Style.txtStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    await _selectDate(context);
                                  },
                                ),
                              ],
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
                                        .format(_currentDate!),
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
                            Container(
                              height: 400,
                              child: LineChart(
                                LineChartData(
                                  minY: 0,
                                  // Минимальное значение по оси Y
                                  maxY: 100,
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              value.toInt().toString(),
                                              // Отображение веса
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          // Отображение даты в формате dd.MM
                                          int index = value.toInt();
                                          if (index >= 0 &&
                                              index < _weightDates.length) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(
                                                DateFormat('dd.MM').format(
                                                    _weightDates[index]),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                            );
                                          }
                                          return Container(); // Пустое значение, если индекс вне диапазона
                                        },
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: true),
                                  gridData: FlGridData(show: true),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: _weightData
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        int index = entry.key;
                                        double value = entry.value.toDouble();
                                        return FlSpot(
                                            index.toDouble(),
                                            value.clamp(0,
                                                100)); // Ограничение значения от 0 до 100
                                      }).toList(),
                                      isCurved: true,
                                      color: Color.fromRGBO(60, 169, 236, 1),
                                      dotData: FlDotData(show: true),
                                      belowBarData: BarAreaData(show: false),
                                    ),
                                    LineChartBarData(
                                      spots: _goalWeight > 0
                                          ? List.generate(
                                              _weightData.length < 7
                                                  ? 7
                                                  : _weightData.length,
                                              (index) {
                                              return FlSpot(index.toDouble(),
                                                  _goalWeight.toDouble());
                                            })
                                          : [],
                                      isCurved: false,
                                      color: Color.fromRGBO(203, 146, 255, 1),
                                      dotData: FlDotData(show: false),
                                      belowBarData: BarAreaData(show: false),
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
                ),
              ],
            ),
          );
        }),
      );
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      dialogBackgroundColor: Style.darkBlue,
      config: CalendarDatePicker2WithActionButtonsConfig(
        lastMonthIcon: Icon(
          Icons.arrow_back_ios,
          color: Color.fromRGBO(203, 146, 255, 1),
        ),
        nextMonthIcon: Icon(
          Icons.arrow_forward_ios,
          color: Color.fromRGBO(203, 146, 255, 1),
        ),
        controlsTextStyle: TextStyle(
          color: Color.fromRGBO(203, 146, 255, 1),
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
          color: Color.fromRGBO(203, 146, 255, 1),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        monthTextStyle: TextStyle(
          color: Color.fromRGBO(203, 146, 255, 1),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        calendarType: CalendarDatePicker2Type.single,
        cancelButton: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 82,
            height: 42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: Color.fromRGBO(203, 146, 255, 1),
                )),
            child: Center(
              child: GradientText(
                'Cancel',
                style: Style.txtStyle.copyWith(
                  fontSize: 16,
                ),
                colors: Style.purpleGrad,
              ),
            ),
          ),
        ),
        okButton: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (_dates.isNotEmpty) {
              setState(() {
                _currentDate = _dates.first;
              });
            }
            Navigator.of(context).pop();
          },
          child: Container(
            width: 82,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: Style.purpleGrad),
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
      });
    }
  }

  void _showWeightDialog(
    TextEditingController controller,
    String title,
    String weightType,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Style.darkBlue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Style.txtStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: Style.txtStyle.copyWith(fontSize: 16),
          ),
          actions: [
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 82,
                height: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    border: Border.all(
                      width: 1,
                      color: Color.fromRGBO(203, 146, 255, 1),
                    )),
                child: Center(
                  child: GradientText(
                    'Cancel',
                    style: Style.txtStyle.copyWith(
                      fontSize: 16,
                    ),
                    colors: Style.purpleGrad,
                  ),
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () {
                setState(() {
                  int weightValue = int.tryParse(controller.text.trim()) ?? 0;
                  if (weightType == 'startWeight') {
                    if (_startWeightString == '0.0 кг') {
                      _startWeightString = '$weightValue кг';
                      _saveWeight('startWeight', weightValue.toDouble());
                    } else {
                      print('dfkskdf: ${weightValue}');
                      _startWeightString = '$weightValue кг';
                      _replaceCurrent(weightValue.toDouble());
                    }
                  } else if (weightType == 'currentWeight') {
                    _currentWeightString = '$weightValue кг';
                    _saveWeight('currentWeight', weightValue.toDouble());
                  } else if (weightType == 'goalWeight') {
                    _goalWeightString = '$weightValue кг';
                    _goalWeight = weightValue;
                    _saveInPrefs('goalWeight', weightValue.toDouble());
                  }
                });
                controller.clear();
                Navigator.of(context).pop();
              },
              child: Container(
                width: 82,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: Style.purpleGrad),
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
          ],
        );
      },
    );
  }
}
