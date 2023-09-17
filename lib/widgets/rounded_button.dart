import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function() onTap;

  const CustomRoundedButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 50.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF60C7FF),
              Color(0xFF2585FD),
            ],
          ),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'TRY AGAIN',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'GothamSSm',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
