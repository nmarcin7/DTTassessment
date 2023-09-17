import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BedroomValue extends StatelessWidget {
  final int? bedrooms;

  const BedroomValue({
    super.key,
    required this.bedrooms,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$bedrooms',
      style: TextStyle(
        fontFamily: 'GothamSSm',
        color: Color(0xFF949494),
        fontSize: 10.sp,
      ),
    );
  }
}

class BathroomValue extends StatelessWidget {
  final int? bathrooms;

  const BathroomValue({Key? key, this.bathrooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$bathrooms',
      style: TextStyle(
        fontFamily: 'GothamSSm',
        color: Color(0xFF949494),
        fontSize: 10.sp,
      ),
    );
  }
}

class SizeValue extends StatelessWidget {
  final int? size;
  const SizeValue({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$size',
      style: TextStyle(
        fontFamily: 'GothamSSm',
        color: Color(0xFF949494),
        fontSize: 10.sp,
      ),
    );
  }
}

class LocationValue extends StatelessWidget {
  final String? location;

  const LocationValue({Key? key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$location',
      style: TextStyle(
        fontFamily: 'GothamSSm',
        color: Color(0xFF949494),
        fontSize: 10.sp,
      ),
    );
  }
}

class PriceValue extends StatelessWidget {
  const PriceValue({
    super.key,
    required this.currencyFormat,
    required this.price,
  });

  final NumberFormat currencyFormat;
  final int? price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${currencyFormat.format(price)}',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
