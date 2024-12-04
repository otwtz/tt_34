import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_bloc.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_event.dart';
import 'package:tt_34/BLoCs/Entry_bloc/entry_state.dart';
import 'package:tt_34/Widgets/listview_of_entries.dart';

import '../../Widgets/gradient_text.dart';
import '../../style.dart';
import 'entry.dart';

class DayAndEntries extends StatefulWidget {
  const DayAndEntries({super.key});

  @override
  State<DayAndEntries> createState() => _DayAndEntriesState();
}

class _DayAndEntriesState extends State<DayAndEntries> {
  DateTime? selectedDate = DateTime.now();
  List<DateTime?> _dates = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(builder: (context, state) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Style.blueGrad,
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      'Notes',
                      style: Style.txtStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                CupertinoButton(
                  child: SvgPicture.asset(
                      'Assets/Icons/lets-icons_calendar-fill.svg'),
                  onPressed: () async {
                    await _selectDate(context);
                  },
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
                  child: Column(children: [
                    EasyDateTimeLine(
                      onDateChange: (date) {
                        context
                            .read<RecordBloc>()
                            .add(GetRecordsByDateEvent(date));
                      },
                      initialDate: selectedDate!,
                      headerProps: EasyHeaderProps(
                          showHeader: true,
                          monthPickerType: MonthPickerType.switcher,
                          monthStyle: Style.txtStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                          showSelectedDate: false
                          // selectedDateStyle: Style.txtStyle.copyWith(fontSize: 12,fontWeight: FontWeight.w400),
                          ),
                      dayProps: EasyDayProps(
                        dayStructure: DayStructure.dayNumDayStr,
                        inactiveDayNumStyle:
                            TextStyle(color: Colors.white, fontSize: 20),
                        width: 30,
                        height: 30,
                        activeDayDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: Style.blueGrad,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        inactiveDayDecoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    state.currentEntryByDate.isNotEmpty
                        ? Expanded(
                            child: EntryListScreen(
                                entries: state.currentEntryByDate))
                        : Container(),
                  ]),
                ),
              ),
            ),
          ]),
        ),
        floatingActionButton: CupertinoButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EntryControlScreen()));
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: Style.blueGrad),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
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
          color: Color.fromRGBO(60, 169, 236, 1),
        ),
        nextMonthIcon: Icon(
          Icons.arrow_forward_ios,
          color: Color.fromRGBO(60, 169, 236, 1),
        ),
        controlsTextStyle: TextStyle(
          color: Color.fromRGBO(60, 169, 236, 1),
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
          color: Color.fromRGBO(60, 169, 236, 1),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        monthTextStyle: TextStyle(
          color: Color.fromRGBO(60, 169, 236, 1),
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
                  color: Color.fromRGBO(60, 169, 236, 1),
                )),
            child: Center(
              child: GradientText(
                'Cancel',
                style: Style.txtStyle.copyWith(
                  fontSize: 16,
                ),
                colors: Style.blueGrad,
              ),
            ),
          ),
        ),
        okButton: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (_dates.isNotEmpty) {
              setState(() {
                selectedDate = _dates.first;
              });
              context
                  .read<RecordBloc>()
                  .add(GetRecordsByDateEvent(selectedDate!));
            }
            Navigator.of(context).pop();
          },
          child: Container(
            width: 82,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: Style.blueGrad),
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
}
