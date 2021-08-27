import 'package:blue_cross/providers/history_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemperatureActions extends StatefulWidget {
  @override
  _TemperatureActionsState createState() => _TemperatureActionsState();
}

class _TemperatureActionsState extends State<TemperatureActions> {
  String _from = 'dc';
  String _to = 'df';
  double _value = 0;
  double _answer = 0;

  void convert(String from, String to, double value) async {
    if (value == 0) {
      return;
    }
    if (from == to) {
      setState(() {
        _answer = value;
      });
    }
    if (from == 'dc' && to == 'df') {
      setState(() {
        _answer = (value * 9) / 5 + 32;
      });
    }
    if (from == 'df' && to == 'dc') {
      setState(() {
        _answer = ((value - 32) * 5) / 9;
      });
    }
    HistoryItem _newHistory =
        new HistoryItem(from: _from, to: _to, value: _value.toString());

    try {
      await Provider.of<History>(context, listen: false)
          .addHistory(_newHistory);
    } catch (e) {
      print(e);
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              DropdownButton(
                value: _from,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      "Celsius " + "\u2103",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: 'dc',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Fahrenheit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: 'df',
                  ),
                ],
                hint: Text('Length Scale'),
                onChanged: (from) {
                  setState(() {
                    _from = from;
                  });
                },
              ),
              SizedBox(
                width: 100,
              ),
              DropdownButton(
                value: _to,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      "Celsius " + "\u2103 ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: 'dc',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Farenheit" + " \u2109",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: 'df',
                  ),
                ],
                hint: Text('Length Scale'),
                onChanged: (to) {
                  setState(() {
                    _to = to;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(9),
                  border:
                      Border.all(color: Theme.of(context).secondaryHeaderColor),
                ),
                width: MediaQuery.of(context).size.width * 0.32,
                child: TextField(
                  cursorHeight: 25,
                  onSubmitted: (value) =>
                      convert(_from, _to, double.parse(value)),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: '  Enter value...',
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  onChanged: (value) {
                    setState(() {
                      _value = double.tryParse(value);
                    });
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                _from == 'dc' ? " \u2103" : " \u2109",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                '=',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.21,
                child: Text(
                  _answer.toStringAsFixed(3),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                _to == 'dc' ? " \u2103" : " \u2109",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          FlatButton(
            onPressed: () => convert(_from, _to, _value),
            child: Text(
              'Convert',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
