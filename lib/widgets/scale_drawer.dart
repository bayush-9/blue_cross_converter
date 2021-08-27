import 'package:blue_cross/screens/history_Screen.dart';
import 'package:blue_cross/screens/length_conversion.dart';
import 'package:blue_cross/screens/temperature_conversion.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('What you want to convert!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.linear_scale),
            title: Text('Length'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, LengthConversionScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.thermostat_outlined),
            title: Text('Temperature'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, TemperatureConversionScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.restorablePushNamed(context, HistoryScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
