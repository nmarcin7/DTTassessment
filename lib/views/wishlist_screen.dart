import 'package:dtt_view_houses_app/controllers/geolocator_controller.dart';
import 'package:dtt_view_houses_app/controllers/wishlist_controller.dart';
import 'package:dtt_view_houses_app/icons/icons_svg.dart';
import 'package:dtt_view_houses_app/models/house_model.dart';
import 'package:dtt_view_houses_app/repository/api_service.dart';
import 'package:dtt_view_houses_app/views/house_detail_screen.dart';
import 'package:dtt_view_houses_app/views/wishlist_screen.dart';
import 'package:dtt_view_houses_app/widgets/house_items.dart';
import 'package:dtt_view_houses_app/widgets/reusable_svg_icon.dart';
import 'package:dtt_view_houses_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:dtt_view_houses_app/widgets/reusable_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    context.read<WishlistController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (context.watch<WishlistController>().wishListHouses.isEmpty)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                        height: 300.h,
                        image: AssetImage('Assets/Images/wishlistempty.png'),
                      ),
                    ),
                    Text(
                      'Ooops!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Your wish list is empty',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount:
                      context.watch<WishlistController>().wishListHouses.length,
                  itemBuilder: (context, index) {
                    final houseLat = context
                        .read<ApiService>()
                        .fetchedHouses[index]
                        .latitude;
                    final houseLon = context
                        .read<ApiService>()
                        .fetchedHouses[index]
                        .longitude;

                    final distance = context
                        .watch<GeolocatorController>()
                        .calculateDistance(
                            houseLat!.toDouble(),
                            houseLon!.toDouble(),
                            context.read<GeolocatorController>().latitude ?? 0,
                            context.read<GeolocatorController>().longitude ??
                                0);
                    final house = context
                        .read<WishlistController>()
                        .wishListHouses[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => HouseDetail(
                                    size: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .size,
                                    description: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .description,
                                    bathrooms: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .bathrooms,
                                    bedrooms: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .bedrooms,
                                    city: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .city,
                                    zip: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .zip,
                                    imageUrl: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .image,
                                    price: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .price,
                                    latitude: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .latitude,
                                    longitude: context
                                        .read<ApiService>()
                                        .fetchedHouses[index]
                                        .longitude,
                                    location: distance,
                                  ),
                              transitionsBuilder: (_, animation, __, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300)),
                        );
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                'Are you sure to delete this house from the wish list?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<WishlistController>()
                                        .deleteHouse(house);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'YES',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'NO',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: ReusableHouseCard(
                        size: house.size,
                        bathrooms: house.bathrooms,
                        bedrooms: house.bedrooms,
                        city: house.city,
                        zip: house.zip,
                        price: house.price,
                        imageUrl: house.image,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
