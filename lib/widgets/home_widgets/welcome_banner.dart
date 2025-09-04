import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
  final String userName;

  const WelcomeBanner({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/images/Home/morning2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good morning, $userName!",
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.375,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "We are glad to have you back",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange[300],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wb_sunny,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
