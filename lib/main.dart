import 'package:blue_cross/providers/history_management.dart';
import 'package:blue_cross/screens/history_Screen.dart';
import 'package:blue_cross/screens/length_conversion.dart';
import 'package:blue_cross/screens/temperature_conversion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => History(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
            secondaryHeaderColor: Colors.red,
          ),
          home: LengthConversionScreen(),
          routes: {
            LengthConversionScreen.routeName: (ctx) => LengthConversionScreen(),
            TemperatureConversionScreen.routeName: (ctx) =>
                TemperatureConversionScreen(),
            HistoryScreen.routeName: (ctx) => HistoryScreen(),
          },
        ));
  }
}
