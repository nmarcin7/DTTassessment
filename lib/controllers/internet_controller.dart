import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class InternetController extends ChangeNotifier {
  bool isOnline = false;

  // This method checks the device's internet connectivity status
  // and updates the isOnline variable accordingly.
  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      isOnline = true;
      notifyListeners();
    } else {
      isOnline = false;
      notifyListeners();
    }
  }
}
