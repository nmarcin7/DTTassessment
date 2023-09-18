import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dtt_view_houses_app/models/house_model.dart';

class ApiService extends ChangeNotifier {
  final _url = Uri.parse('https://intern.d-tt.nl/api/house');
  final _accessKey = '98bww4ezuzfePCYFxJEWyszbUXc7dxRx';

  final List<House> fetchedHouses = [];

  // This method retrieves data (house listings) from a remote API and populates the fetchedHouses
  // list with this data. It also sorts the list based on house prices.
  Future<void> getData() async {
    fetchedHouses.clear();
    final response = await http.get(_url, headers: {'Access-Key': _accessKey});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;

      jsonData.forEach((element) {
        final house = House.fromJson(element);
        fetchedHouses.add(house);
        fetchedHouses.sort((a, b) =>
            a.price!.compareTo(b.price!)); // Sorting list by its price
        notifyListeners();
      });
    } else {
      notifyListeners();
      throw Exception('something went wrong');
    }
  }
}
