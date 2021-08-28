import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HistoryItem {
  final String from;
  final String to;
  final String value;
  final DateTime dateTime;

  HistoryItem({
    this.from,
    this.to,
    this.value,
    this.dateTime,
  });
}

class History with ChangeNotifier {
  List<HistoryItem> _history = [];

  List<HistoryItem> get history {
    return [..._history];
  }

  Future<void> fetchHistory() async {
    final url = Uri.parse(
        'https://blue-cross-68bcf-default-rtdb.asia-southeast1.firebasedatabase.app/history.json');
    final response = await http.get(url);
    List<HistoryItem> loadedHistory = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, historyItems) {
      loadedHistory.add(
        HistoryItem(
          from: historyItems['from'],
          to: historyItems['to'],
          dateTime: DateTime.parse(
            historyItems['datetime'],
          ),
          value: historyItems['value'],
        ),
      );
    });
    _history = loadedHistory;
    notifyListeners();
  }

  Future<void> deleteHistory() async {
    final url = Uri.parse(
        'https://blue-cross-68bcf-default-rtdb.asia-southeast1.firebasedatabase.app/history.json');
    final response = http.delete(url);
    _history.clear();
    notifyListeners();
  }

  Future<void> addHistory(HistoryItem _newHistoryItem) async {
    final url = Uri.parse(
        'https://blue-cross-68bcf-default-rtdb.asia-southeast1.firebasedatabase.app/history.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'from': _newHistoryItem.from,
          'to': _newHistoryItem.to,
          'value': _newHistoryItem.value,
          'datetime': DateTime.now().toIso8601String(),
        }),
      );
      final HistoryItem addeditem = HistoryItem(
          from: _newHistoryItem.from,
          to: _newHistoryItem.to,
          value: _newHistoryItem.value);
      _history.add(addeditem);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
    print(_history);
  }
}
