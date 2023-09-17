import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReusableSvgIcon extends StatelessWidget {
  final String icon;
  final double? width;
  final double? height;
  final Color? color;
  ReusableSvgIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
      width: width,
      height: height,
    );
  }
}
