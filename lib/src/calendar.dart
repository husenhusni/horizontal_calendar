library horizontal_calendar;

import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

typedef OnDateSelected(date);

class HorizontalCalendar extends StatefulWidget {
  HorizontalCalendar({
    Key? key,
    required this.date,
    this.initialDate,
    this.lastDate,
    this.textColor,
    this.dateNameStyle,
    this.selectedSecondaryColor,
    this.dateNumberStyle,
    this.backgroundColor,
    this.selectedColor,
    this.showMonth = false,
    required this.onDateSelected,
  }) : super(key: key);

  final DateTime date;
  final DateTime? initialDate /*!*/;
  final DateTime? lastDate /*!*/;
  final Color? textColor /*!*/;
  final Color? backgroundColor /*!*/;
  final Color? selectedColor /*!*/;
  final Color? selectedSecondaryColor /*!*/;
  final bool showMonth;
  final TextStyle? dateNameStyle;
  final TextStyle? dateNumberStyle;
  final OnDateSelected onDateSelected;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<HorizontalCalendar> {
  late DateTime _startDate;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    _startDate = selectedDate.subtract(Duration(days: 3));

    return Container(
      height: height * (widget.showMonth ? 12 : 10),
      color: widget.backgroundColor ?? Colors.white,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.all(0.0),
        title: widget.showMonth
            ? Text(
                DateParser.getMonth(selectedDate),
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: widget.selectedColor ??
                          Theme.of(context).primaryColor,
                    ),
              )
            : Offstage(),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int index = 0; index < 6; index++)
                      CalendarItems(
                        index: index,
                        selectedSecondaryColor: widget.selectedSecondaryColor ??
                            Theme.of(context).primaryColor,
                        dateNumberStyle: widget.dateNumberStyle,
                        startDate: _startDate,
                        initialDate:
                            widget.initialDate ?? new DateTime(2010, 10, 10),
                        selectedDate: selectedDate,
                        dateNameStyle: widget.dateNameStyle,
                        textColor: widget.textColor ?? Colors.black45,
                        selectedColor: widget.selectedColor ??
                            Theme.of(context).primaryColor,
                        backgroundColor: widget.backgroundColor ?? Colors.white,
                        onDatePressed: () {
                          onDatePressed(index, widget.initialDate);
                        },
                      )
                  ],
                ),
              ),
            ),
            CalendarButton(
              textColor: widget.textColor ?? Colors.black45,
              backgroundColor: widget.backgroundColor ?? Colors.white,
              onCalendarPressed: () async {
                DateTime? date = await selectDate();
                if (date != null) {
                  widget.onDateSelected(date);
                  setState(() => selectedDate = date);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> selectDate() async {
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedDate,
      firstDate: widget.initialDate ?? new DateTime(2010, 10, 10),
      lastDate: widget.lastDate ?? DateTime.now().add(Duration(days: 90)),
    );
  }

  void onDatePressed(int index, DateTime? initialDate) {
    DateTime date = _startDate.add(Duration(days: index));
    int diffDays = date.difference(selectedDate).inDays;
    int checkDate =
        date.difference(widget.initialDate ?? DateTime.now()).inDays;
    widget.onDateSelected(date);
    setState(() {
      selectedDate = _startDate.add(Duration(days: index));
      _startDate = _startDate.add(Duration(days: index));
    });
    // if (checkDate >= 0) {
    //   widget.onDateSelected(DateParser.getDate(date));
    //   setState(() {
    //     selectedDate = _startDate.add(Duration(days: index));
    //     _startDate = _startDate.add(Duration(days: index));
    //   });
    // }
  }
}
