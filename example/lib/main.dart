import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Horizontal Calendar Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: HorizontalCalendar(
          selectedSecondaryColor: Color.fromARGB(255, 38, 36, 36),
          date: DateTime.now(),
          dateNumberStyle: 0 == 0
              ? theme.textTheme.bodyLarge!.copyWith(color: Colors.black)
              : theme.textTheme.headline5!
                  .copyWith(color: theme.accentColor.withOpacity(0.5)),
          dateNameStyle: 0 == 0
              ? theme.textTheme.bodyLarge!.copyWith(color: Colors.black)
              : theme.textTheme.headline4!
                  .copyWith(color: theme.accentColor.withOpacity(0.5)),
          textColor: theme.accentColor.withOpacity(0.5),
          backgroundColor: Colors.white,
          selectedColor: Color.fromARGB(95, 168, 55, 55),
          onDateSelected: (date) {
            print(date);
          }),
    );
  }
}
