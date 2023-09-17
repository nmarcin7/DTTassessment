import 'package:flutter/material.dart';

class AddressText extends StatelessWidget {
  final String? address;
  const AddressText({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$address',
      style: const TextStyle(
        color: Color(0xFF949494),
      ),
    );
  }
}
