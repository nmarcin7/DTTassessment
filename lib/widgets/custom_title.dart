import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTitle extends StatelessWidget {
  final String? title;

  const CustomTitle({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
