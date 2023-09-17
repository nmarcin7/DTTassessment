import 'package:dtt_view_houses_app/widgets/custom_title.dart';
import 'package:flutter/material.dart';

import 'package:dtt_view_houses_app/controllers/url_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationScreen extends StatelessWidget {
  final websiteUrl = Uri.parse('https://www.d-tt.nl/');
  UrlController urlController = UrlController();

  InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 30.h),
                child: const CustomTitle(
                  title: 'ABOUT',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. Nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore. Eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. Nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore. Eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident. ',
                  // style: TextStyle(
                  //   fontFamily: 'GothamSSm',
                  //   fontSize: 12.sp,
                  //   color: Color(0xFF949494),
                  // ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h),
                child: const CustomTitle(
                  title: 'DESIGN AND DEVELOPMENT',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Row(
                  children: [
                    Image.asset(
                      'Assets/Images/dtt_banner/ldpi/dtt_banner.png',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Column(
                        children: [
                          Text('by DTT',
                              style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(
                            height: 5.h,
                          ),
                          InkWell(
                            onTap: () {
                              urlController.openUrl();
                            },
                            child: Text(
                              'd-tt.nl',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
