import 'package:flutter/material.dart';

import '../models/CounterModels.dart';

class CounterProvider extends ChangeNotifier {
  int c = 0;
  Counter counter = Counter(cnt: 0);
  increseCounter() {
    counter.cnt++;
    notifyListeners();
  }
}