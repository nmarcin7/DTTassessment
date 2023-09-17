import 'dart:async';

import 'package:dtt_view_houses_app/controllers/map_controller.dart';
import 'package:dtt_view_houses_app/controllers/theme_controller.dart';
import 'package:dtt_view_houses_app/icons/icons_svg.dart';
import 'package:dtt_view_houses_app/repository/api_service.dart';
import 'package:dtt_view_houses_app/widgets/custom_title.dart';
import 'package:dtt_view_houses_app/widgets/reusable_svg_icon.dart';
import 'package:dtt_view_houses_app/widgets/house_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:dtt_view_houses_app/icons/icons_svg.dart';
import 'package:provider/provider.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HouseDetail extends StatelessWidget {
  final String? imageUrl;
  final int? price;
  final String? zip;
  final String? city;
  final int? bedrooms;
  final int? bathrooms;
  final int? size;
  final String? description;
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'en_US', symbol: '\$');
  final int? latitude;
  final int? longitude;
  final double? location;

  HouseDetail(
      {Key? key,
      this.imageUrl,
      this.price,
      this.zip,
      this.city,
      this.bedrooms,
      this.bathrooms,
      this.size,
      this.description,
      this.latitude,
      this.longitude,
      this.location})
      : super(key: key);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _markers = {
      Marker(
        onTap: () {
          MapController.launchGoogleMaps(
              latitude!.toDouble(), longitude!.toDouble());
        },
        markerId: MarkerId('redMarker'),
        position: LatLng(latitude!.toDouble(), longitude!.toDouble()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.network(
              'https://intern.d-tt.nl$imageUrl',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              height: 200.h,
            ),
            Positioned(
              top: 30.h,
              left: 20.w,
              child: IconButton(
                onPressed: () {},
                icon: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ReusableSvgIcon(
                    icon: backIcon,
                    width: 30.w,
                    height: 30.h,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180.h,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: context.watch<ThemeController>().isDarkMode
                      ? Color(0xFF313131)
                      : Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.r),
                    topLeft: Radius.circular(25.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PriceValue(
                                currencyFormat: currencyFormat, price: price),
                            Row(
                              children: [
                                ReusableSvgIcon(
                                  icon: bedIcon,
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF949494),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                BedroomValue(bedrooms: bedrooms),
                                SizedBox(
                                  width: 5.w,
                                ),
                                ReusableSvgIcon(
                                  icon: bathIcon,
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF949494),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                BathroomValue(
                                  bathrooms: bathrooms,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                ReusableSvgIcon(
                                  icon: layersIcon,
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF949494),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                SizeValue(
                                  size: size,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                ReusableSvgIcon(
                                  icon: locationIcon,
                                  height: 15.h,
                                  width: 15.w,
                                  color: Color(0xFF949494),
                                ),
                                LocationValue(
                                  location: '${location}km',
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.w),
                        child: const CustomTitle(
                          title: 'Description',
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 30.w, top: 20.h, right: 30.w),
                        child: Text(
                          '$description',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.sp, top: 20.sp),
                        child: const CustomTitle(
                          title: 'Location',
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200.h,
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GoogleMap(
                          onTap: (position) {
                            MapController.launchGoogleMaps(
                              position.latitude!.toDouble(),
                              position.longitude!.toDouble(),
                            );
                          },
                          markers: _markers,
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            zoom: 12.0,
                            target: LatLng(
                              latitude!.toDouble(),
                              longitude!.toDouble(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
