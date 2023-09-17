import 'package:dtt_view_houses_app/controllers/geolocator_controller.dart';
import 'package:dtt_view_houses_app/controllers/internet_controller.dart';
import 'package:dtt_view_houses_app/controllers/wishlist_controller.dart';
import 'package:dtt_view_houses_app/models/house_model.dart';
import 'package:dtt_view_houses_app/views/house_detail_screen.dart';
import 'package:dtt_view_houses_app/views/wishlist_screen.dart';

import 'package:dtt_view_houses_app/widgets/custom_title.dart';
import 'package:dtt_view_houses_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:dtt_view_houses_app/widgets/reusable_card.dart';
import 'package:dtt_view_houses_app/repository/api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OverViewScreen extends StatefulWidget {
  OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  TextEditingController _controller = TextEditingController();

  ApiService apiService = ApiService();
  List<House> _filteredHouses = [];

  var connectivityResult;

  void _clearText() {
    _controller.clear();
  }

  Future<void> _refreshData() async {
    context.read<ApiService>().getData(); // Fetch the latest data from a server
    _filteredHouses = context
        .read<ApiService>()
        .fetchedHouses; // Assign the data to another list in order to filter through it
    setState(() {}); // Refresh the user interface
  }

  @override
  void initState() {
    super.initState();
    context
        .read<InternetController>()
        .checkConnection(); // Check the internet connection status and update the UI accordingly
    context
        .read<ApiService>()
        .getData(); // Fetch data from the API service and update the list of houses.
    _filteredHouses = context.read<ApiService>().fetchedHouses;
    context.read<GeolocatorController>().checkLocationPermission();
    context.read<WishlistController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 30.h),
              child: const CustomTitle(
                title: 'DTT REAL ESTATE',
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                style: Theme.of(context).textTheme.labelMedium,
                onChanged: (value) {
                  _filteredHouses = context
                      .read<ApiService>()
                      .fetchedHouses
                      .where((house) =>
                          house.zip!.contains(value) ||
                          house.city!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                      .toList();
                  setState(() {});
                },
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  filled: true,
                  hintText: 'Search for a home',
                  border: InputBorder.none,
                  suffixIcon: _controller.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            _clearText();
                            _filteredHouses =
                                context.read<ApiService>().fetchedHouses;
                            setState(() {});
                          },
                          child: Icon(Icons.clear),
                        )
                      : Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            if (context.watch<InternetController>().isOnline == true)
              Expanded(
                child: Consumer<ApiService>(
                  builder: (context, apiService, child) {
                    if (apiService.fetchedHouses.isEmpty) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    } else if (_filteredHouses.isEmpty) {
                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'Assets/Images/search_state_empty.png',
                                width: 250.w,
                                height: 250.w,
                              ),
                              Text(
                                'No results found!',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                'Perhaps try another search?',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final house = _filteredHouses[index];
                            final houseLat = _filteredHouses[index].latitude;
                            final houseLon = _filteredHouses[index].longitude;

                            final distance = context
                                .watch<GeolocatorController>()
                                .calculateDistance(
                                    houseLat!.toDouble(),
                                    houseLon!.toDouble(),
                                    context
                                            .read<GeolocatorController>()
                                            .latitude ??
                                        0,
                                    context
                                            .read<GeolocatorController>()
                                            .longitude ??
                                        0);

                            return InkWell(
                              onLongPress: () {
                                context.read<WishlistController>().getData();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: const Text(
                                          'Would you like to add this house to wish list?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            if (context
                                                .read<WishlistController>()
                                                .isHouseInWishlist(house)) {
                                              // Ten domek jest już w ulubionych, wyświetl komunikat
                                              Navigator.pop(context);

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.error,
                                                        color: Colors
                                                            .red, // Kolor ikony błędu
                                                      ),
                                                      SizedBox(
                                                          width: 8
                                                              .w), // Odstęp między ikoną a tekstem
                                                      const Text(
                                                        'This house already exist in the wish list!',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              // context
                                              //     .read<WishlistController>()
                                              //     .getData();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.check,
                                                        color: Colors
                                                            .green, // Kolor ikony błędu
                                                      ),
                                                      SizedBox(
                                                          width: 8
                                                              .w), // Odstęp między ikoną a tekstem
                                                      const Text(
                                                        'The house has been added to the wish list',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );

                                              context
                                                  .read<WishlistController>()
                                                  .saveHouse(house);

                                              Navigator.pop(context);
                                            }

                                            ///////
                                            // context
                                            //     .read<WishlistController>()
                                            //     .saveHouse(house);
                                            // Navigator.pop(context);
                                          },
                                          child: Text('YES'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'NO',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => HouseDetail(
                                            size: _filteredHouses[index].size,
                                            description: _filteredHouses[index]
                                                .description,
                                            bathrooms: _filteredHouses[index]
                                                .bathrooms,
                                            bedrooms:
                                                _filteredHouses[index].bedrooms,
                                            city: _filteredHouses[index].city,
                                            zip: _filteredHouses[index].zip,
                                            imageUrl:
                                                _filteredHouses[index].image,
                                            price: _filteredHouses[index].price,
                                            latitude:
                                                _filteredHouses[index].latitude,
                                            longitude: _filteredHouses[index]
                                                .longitude,
                                            location: distance,
                                          ),
                                      transitionsBuilder:
                                          (_, animation, __, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0, 1),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                      transitionDuration:
                                          Duration(milliseconds: 300)),
                                );
                              },
                              child: ReusableHouseCard(
                                size: _filteredHouses[index].size,
                                bathrooms: _filteredHouses[index].bathrooms,
                                bedrooms: _filteredHouses[index].bedrooms,
                                city: _filteredHouses[index].city,
                                zip: _filteredHouses[index].zip,
                                imageUrl: _filteredHouses[index].image,
                                price: _filteredHouses[index].price,
                                latitude: _filteredHouses[index].latitude,
                                longitude: _filteredHouses[index].longitude,
                                distance: distance,
                              ),
                            );
                          },
                          itemCount: _filteredHouses.length,
                        ),
                      );
                    }
                  },
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('Assets/Images/no-wifi.png'),
                        height: 100.h,
                        width: 100.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Ooops!',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'No internet connection found',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Check your connection and try again',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomRoundedButton(
                        onTap: () {
                          context.read<InternetController>().checkConnection();
                          _refreshData();
                        },
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
