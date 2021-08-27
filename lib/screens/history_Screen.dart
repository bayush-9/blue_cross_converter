import 'package:blue_cross/providers/history_management.dart';
import 'package:blue_cross/widgets/history_list_tile.dart';
import 'package:blue_cross/widgets/scale_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history-screen';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isinit = true;
  bool _isloading = true;

  @override
  void didChangeDependencies() {
    if (_isinit == true) {
      setState(() {
        _isloading = true;
      });
      Provider.of<History>(context, listen: false).fetchHistory().then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      drawer: AppDrawer(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Provider.of<History>(context, listen: false).history.isEmpty
              ? Center(
                  child: Text(
                    'No conversions yet!!',
                    style: TextStyle(fontSize: 36),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    var _extractedHistory = Provider.of<History>(
                      context,
                      listen: false,
                    ).history;

                    return HistoryListTile(
                      _extractedHistory[index].dateTime,
                      _extractedHistory[index].from,
                      index,
                      _extractedHistory[index].to,
                      _extractedHistory[index].value,
                    );
                  },
                  itemCount: Provider.of<History>(context, listen: false)
                      .history
                      .length,
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          _isloading = true;
          await Provider.of<History>(context, listen: false)
              .deleteHistory()
              .then((value) {
            setState(() {
              _isloading = false;
            });
          });
        },
      ),
    );
  }
}
