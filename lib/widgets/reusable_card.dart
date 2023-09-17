import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dtt_view_houses_app/icons/icons_svg.dart';
import 'package:dtt_view_houses_app/widgets/reusable_svg_icon.dart';
import 'package:dtt_view_houses_app/widgets/house_items.dart';

import 'package:intl/intl.dart';
import 'package:dtt_view_houses_app/widgets/address_text.dart';

class ReusableHouseCard extends StatelessWidget {
  final String? imageUrl;
  final int? price;
  final String? zip;
  final String? city;
  final int? bedrooms;
  final int? bathrooms;
  final int? size;
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'en_US', symbol: '\$');
  final int? latitude;
  final int? longitude;
  final double? distance;

  ReusableHouseCard(
      {super.key,
      this.imageUrl,
      this.price,
      this.zip,
      this.city,
      this.bedrooms,
      this.bathrooms,
      this.size,
      this.latitude,
      this.longitude,
      this.distance});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                'https://intern.d-tt.nl$imageUrl',
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PriceValue(currencyFormat: currencyFormat, price: price),
                SizedBox(
                  height: 5.w,
                ),
                Row(
                  children: [
                    AddressText(address: zip),
                    SizedBox(
                      width: 5.w,
                    ),
                    AddressText(address: city),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                Row(
                  children: [
                    ReusableSvgIcon(
                      icon: bedIcon,
                      height: 15.h,
                      width: 15.w,
                      color: Color(0xFF949494),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    BedroomValue(bedrooms: bedrooms),
                    SizedBox(
                      width: 8.w,
                    ),
                    ReusableSvgIcon(
                      icon: bathIcon,
                      height: 15.h,
                      width: 15.w,
                      color: Color(0xFF949494),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    BathroomValue(
                      bathrooms: bathrooms,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    ReusableSvgIcon(
                      icon: layersIcon,
                      height: 15.h,
                      width: 15.w,
                      color: Color(0xFF949494),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    SizeValue(
                      size: size,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    ReusableSvgIcon(
                      icon: locationIcon,
                      height: 15.h,
                      width: 15.w,
                      color: Color(0xFF949494),
                    ),
                    LocationValue(
                      location: '${distance}km',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
