import 'package:flutter/foundation.dart';

class ThemeController extends ChangeNotifier {
  bool isDarkMode = false;
  // This method toggles the dark mode of the application's user interface.
  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
