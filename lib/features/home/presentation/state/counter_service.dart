import 'package:flutter/foundation.dart';

class CounterService extends ChangeNotifier {
  CounterService();
  int _tappedCount = 0;

  int get tappedCount => _tappedCount;

  void incrementTappedCount() {
    _tappedCount++;
    notifyListeners();
  }
}


