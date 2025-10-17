// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:tripitify/models/home_screen/trip_planner.dart';
// import 'package:tripitify/widgets/home_widgets/trip_planner_card.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   bool _showTripPlanner = false;
//
//   final tripPlanners = [
//     const TripPlanner(
//       name: "Joseph Fubara",
//       rating: 4.9,
//       reviews: 127,
//       location: "Paris, France",
//       specialties: ["Romantic", "Wellness & Relaxation"],
//       tripsPlanned: 54,
//       responseTime: "< 1 hours",
//       price: 75,
//       isVerified: true,
//       isAcceptingClients: true,
//       imagePath: 'assets/images/Home/blue_circle.svg',
//     ),
//     const TripPlanner(
//       name: "Maria Rodriguez",
//       rating: 4.8,
//       reviews: 87,
//       location: "Barcelona, Spain",
//       specialties: ["Nature", "Photography", "Culture & History"],
//       tripsPlanned: 89,
//       responseTime: "< 2 hours",
//       price: 60,
//       isVerified: true,
//       isAcceptingClients: true,
//       imagePath: null,
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(() {
//       setState(() {
//         _showTripPlanner = _searchController.text.isNotEmpty;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0, // This keeps the app bar white when scrolling
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: const Color(0xFF3B82F6), // Blue background
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: SvgPicture.asset(
//                 'assets/images/Home/backArrow.svg',
//                 width: 24,
//                 height: 24,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Search bar container
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Container(
//               height: 52,
//               padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF9FAFB), // --Neutral-Gray-50
//                 border: Border.all(
//                   color: const Color(0xFFE5E7EB), // --Neutral-Gray-200
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(12), // --Border-Radius-xl
//               ),
//               child: Row(
//                 children: [
//                   const Icon(
//                     CupertinoIcons.search,
//                     color: Color(0xFF6B7280),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: const InputDecoration(
//                         hintText: 'Search by destination or specialties...',
//                         hintStyle: TextStyle(
//                           color: Color(0xFF6B7280), // --Text-Tertiary
//                           fontFamily: 'Instrument Sans', // --Font-Primary
//                           fontSize: 14, // --Font-Size-sm
//                           fontWeight: FontWeight.w400, // --Font-Weight-normal
//                         ),
//                         border: InputBorder.none,
//                       ),
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Instrument Sans',
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   if (_searchController.text.isNotEmpty)
//                     GestureDetector(
//                       onTap: () {
//                         _searchController.clear();
//                       },
//                       child: const Icon(
//                         CupertinoIcons.clear_circled_solid,
//                         color: Color(0xFF6B7280),
//                         size: 20,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           // Rest of the body content
//           Expanded(
//             child: _showTripPlanner
//                 ? ListView.separated(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     shrinkWrap: true,
//                     itemCount: tripPlanners.length,
//                     separatorBuilder: (context, index) => const SizedBox(height: 12),
//                     itemBuilder: (context, index) {
//                       return TripPlannerCard(planner: tripPlanners[index]);
//                     },
//                   )
//                 : const Center(
//                     child: Text(
//                       'Search results will appear here',
//                       style: TextStyle(
//                         color: Color(0xFF6B7280),
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }