import 'dart:convert';

import 'package:dtt_view_houses_app/models/house_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class WishlistController extends ChangeNotifier {
  List<House> wishListHouses = [];

  final url = Uri.parse(
      'https://dttassessment-e52a0-default-rtdb.europe-west1.firebasedatabase.app/houses.json');

  // method deletes a specific house from the Firebase database, removes it
  // from the local wishListHouses list, and notifies listeners of the data change
  void deleteHouse(House house) async {
    final deteleUrl = Uri.parse(
        'https://dttassessment-e52a0-default-rtdb.europe-west1.firebasedatabase.app/houses/${house.key}.json');

    final response = await http.delete(deteleUrl);
    wishListHouses.removeWhere((element) => element.id == house.id);
    notifyListeners();
  }

  bool isHouseInWishlist(House house) {
    return wishListHouses.any((existingHouse) => existingHouse.id == house.id);
  }

  void getData() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        final List<House> houses = []; // Temporary list

        data.forEach((key, value) {
          final house = House.fromJson(value);
          house.key = key;
          houses.add(house);
        });

        // Temporary list for storing unique houses
        final uniqueHouses = <House>[];

        // Adding only unique houses to the temporary list
        houses.forEach((house) {
          if (!uniqueHouses
              .any((existingHouse) => existingHouse.id == house.id)) {
            uniqueHouses.add(house);
          }
        });

        // Assign the temporary list to wishListHouses
        wishListHouses = uniqueHouses;

        notifyListeners();
        print(wishListHouses);
      } else {
        print('${response.statusCode}');
      }
    } catch (e) {
      print('$e');
    }
  }

  // method saves the information of a house to the Firebase database by sending a POST request
  // with the house data in JSON format to the specified URL.
  void saveHouse(House house) async {
    final houseData = {
      'id': house.id,
      'image': house.image,
      'price': house.price,
      'bedrooms': house.bedrooms,
      'bathrooms': house.bathrooms,
      'size': house.size,
      'description': house.description,
      'zip': house.zip,
      'city': house.city,
      'latitude': house.latitude,
      'longitude': house.longitude,
    };

    await http.post(url, body: jsonEncode(houseData));
  }
}
