import 'package:flutter/cupertino.dart';

class CounterProvider with ChangeNotifier {
  int counter = 1;

  int get value {
    return counter;
  }

  void increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    if (counter == 1) {
      return;
    }
    counter--;
    notifyListeners();
  }

  void resetCounter() {
    counter = 1;
    notifyListeners();
  }
}
