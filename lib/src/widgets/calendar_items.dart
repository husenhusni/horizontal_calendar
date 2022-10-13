import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

class CalendarItems extends StatefulWidget {
  CalendarItems({
    Key? key,
    required this.index,
    required this.startDate,
    required this.initialDate,
    required this.selectedDate,
    required this.textColor,
    required this.dateNameStyle,
    required this.dateNumberStyle,
    required this.selectedColor,
    required this.selectedSecondaryColor,
    required this.backgroundColor,
    required this.onDatePressed,
  }) : super(key: key);

  final int index;
  final DateTime startDate;
  final DateTime initialDate;
  final DateTime selectedDate;
  final Color textColor;
  final TextStyle? dateNameStyle;
  final TextStyle? dateNumberStyle;
  final Color selectedColor;
  final Color backgroundColor;
  final Color selectedSecondaryColor;
  final VoidCallback onDatePressed;

  @override
  State<CalendarItems> createState() => _CalendarItemsState();
}

class _CalendarItemsState extends State<CalendarItems> {
  @override
  Widget build(BuildContext context) {
    DateTime date = widget.startDate.add(Duration(days: widget.index));
    int diffDays = date.difference(widget.selectedDate).inDays;
    int checkPastDate = date.difference(widget.initialDate).inDays;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        widget.onDatePressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: widget.selectedDate == date
            ? EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
            : EdgeInsets.all(10.0),
        decoration: widget.selectedDate == date
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    widget.selectedColor,
                    widget.selectedSecondaryColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Column(
          children: [
            Text(
              '${DateParser.getDayOfWeek(date)}',
              style: this.widget.dateNameStyle ??
                  Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: diffDays != 0
                            ? checkPastDate >= 0
                                ? widget.textColor
                                : Colors.grey[300]
                            : Colors.white,
                        fontSize: 10.0,
                      ),
            ),
            Text(
              '${DateParser.getDayOfMonth(date)}',
              style: this.widget.dateNumberStyle ??
                  Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: diffDays != 0
                            ? checkPastDate >= 0
                                ? widget.textColor
                                : Colors.grey[300]
                            : Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
            ),
          ],
        ),
      ),
    );

    return Container(
      width: (width / 100) * 12.5,
      color: diffDays != 0 ? widget.backgroundColor : widget.selectedColor,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: widget.onDatePressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              DateParser.getDayOfWeek(date),
              style: this.widget.dateNameStyle ??
                  Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: diffDays != 0
                            ? checkPastDate >= 0
                                ? widget.textColor
                                : Colors.grey[300]
                            : Colors.white,
                        fontSize: 10.0,
                      ),
            ),
            SizedBox(height: 2.0),
            Text(
              DateParser.getDayOfMonth(date),
              style: this.widget.dateNumberStyle ??
                  Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: diffDays != 0
                            ? checkPastDate >= 0
                                ? widget.textColor
                                : Colors.grey[300]
                            : Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
