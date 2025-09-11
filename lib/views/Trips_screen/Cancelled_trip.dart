import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';




class CancelledContent extends StatelessWidget {
  const CancelledContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/Trips/Cancel_Circle.svg',
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 12),
          const Text(
            'No cancelled trips',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF111827),
              fontFamily: 'Instrument Sans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.375,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You haven\'t cancelled any trips yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}