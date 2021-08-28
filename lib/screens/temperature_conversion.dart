import 'package:blue_cross/widgets/scale_drawer.dart';
import 'package:blue_cross/widgets/temperature_actions.dart';
import 'package:flutter/material.dart';

class TemperatureConversionScreen extends StatelessWidget {
  static const routeName = '/temperature-conversion';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Text('Convert Temperature'),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 250,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 135,
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'To',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TemperatureActions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
