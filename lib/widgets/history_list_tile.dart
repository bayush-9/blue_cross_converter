import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryListTile extends StatelessWidget {
  String from = '';
  String to = '';
  String value = '';
  int rank = 0;
  DateTime dateTime;

  HistoryListTile(
    this.dateTime,
    this.from,
    this.rank,
    this.to,
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(children: [
        Text(value + ' '),
        if (from == 'dc') Text('\u2103'),
        if (from == 'df') Text('\u2109'),
        if (from == 'inches') Text('inches'),
        if (from == 'feet') Text('feet'),
        if (from == 'cm') Text('centimeters'),

        // if (from != 'dc' || from != 'df') Text(from + ' '),
        Text(' to '),

        if (to == 'dc') Text('\u2103'),
        if (to == 'df') Text('\u2109'),
        if (to == 'inches') Text('inches'),
        if (to == 'feet') Text('feet'),
        if (to == 'cm') Text('centimeters'),
      ]),
      leading: CircleAvatar(
        child: FittedBox(fit: BoxFit.cover, child: Text((rank + 1).toString())),
      ),
      subtitle: Text(
        DateFormat.yMMMEd().format(dateTime),
      ),
    );
  }
}
