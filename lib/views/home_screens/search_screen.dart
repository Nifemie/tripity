import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0, // This keeps the app bar white when scrolling
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6), // Blue background
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/back_arrow.svg', // Add your own back arrow SVG here
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              height: 52,
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB), // --Neutral-Gray-50
                border: Border.all(
                  color: const Color(0xFFE5E7EB), // --Neutral-Gray-200
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12), // --Border-Radius-xl
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search by destination or specialties...',
                        hintStyle: TextStyle(
                          color: Color(0xFF6B7280), // --Text-Tertiary
                          fontFamily: 'Instrument Sans', // --Font-Primary
                          fontSize: 14, // --Font-Size-sm
                          fontWeight: FontWeight.w400, // --Font-Weight-normal
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Rest of the body content
          const Expanded(
            child: Center(
              child: Text(
                'Search results will appear here',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Usage example:
