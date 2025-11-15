import 'package:flutter/material.dart';

class TravelCalendarScreen extends StatefulWidget {
  const TravelCalendarScreen({super.key});

  @override
  State<TravelCalendarScreen> createState() => _TravelCalendarScreenState();
}

class _TravelCalendarScreenState extends State<TravelCalendarScreen> {
  DateTime selectedMonth = DateTime(2025, 8);

  // Sample trip dates with status
  final Map<int, String> tripDates = {
    2: 'completed',
    4: 'completed',
    16: 'confirmed',
    27: 'ongoing',
    28: 'ongoing',
    29: 'ongoing',
    30: 'ongoing',
  };

  void _previousMonth() {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Travel Calendar',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar Widget
              _CalendarWidget(
                selectedMonth: selectedMonth,
                tripDates: tripDates,
                onPreviousMonth: _previousMonth,
                onNextMonth: _nextMonth,
              ),

              const SizedBox(height: 32),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        BoxBorder.all(color: Colors.grey.shade200, width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Legend
                    const Text(
                      'Status Legend',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _LegendItem(
                      color: const Color(0xFFF97316),
                      label: 'Confirmed, not ongoing',
                    ),
                    const SizedBox(height: 12),
                    _LegendItem(
                      color: const Color(0xFF3B82F6),
                      label: 'Ongoing',
                    ),
                    const SizedBox(height: 12),
                    _LegendItem(
                      color: const Color(0xFF10B981),
                      label: 'Completed',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Upcoming Trips
              const Text(
                'Upcoming Trips',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 16),

              // Trip Card
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _TripCard(
                      imageUrl: 'assets/images/Home/capetown.png',
                      title: '5 Days in Cape Town',
                      status: 'Confirmed',
                      location: 'Cape Town, South Africa',
                      dates: 'Jul 27 - 31, 2025',
                      travelers: 'Solo',
                      price: '\$1800',
                      planner: 'Joseph Fubara',
                    ),
                    SizedBox(width: 12),
                    _TripCard(
                      imageUrl: 'assets/images/Home/capetown.png',
                      title: '2 Days in Cape Town',
                      status: 'Confirmed',
                      location: 'Cape Town, South Africa',
                      dates: 'Jul 29 - 30, 2026',
                      travelers: 'Bube',
                      price: '\$1300',
                      planner: 'Michael John',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// Calendar Widget
class _CalendarWidget extends StatelessWidget {
  final DateTime selectedMonth;
  final Map<int, String> tripDates;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const _CalendarWidget({
    required this.selectedMonth,
    required this.tripDates,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    final monthName = _getMonthName(selectedMonth.month);
    final year = selectedMonth.year;
    final daysInMonth = DateTime(year, selectedMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(year, selectedMonth.month, 1);
    final startingWeekday = firstDayOfMonth.weekday % 7;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey.shade200)),
      child: Column(
        children: [
          // Month Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onPreviousMonth,
                icon: const Icon(Icons.chevron_left, color: Color(0xFF6B7280)),
              ),
              Text(
                '$monthName $year',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              IconButton(
                onPressed: onNextMonth,
                icon: const Icon(Icons.chevron_right, color: Color(0xFF6B7280)),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Weekday Headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map((day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),

          const SizedBox(height: 12),

          // Calendar Grid
          ...List.generate(6, (weekIndex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (dayIndex) {
                  final dayNumber =
                      weekIndex * 7 + dayIndex - startingWeekday + 1;

                  if (dayNumber < 1 || dayNumber > daysInMonth) {
                    return const SizedBox(width: 40, height: 40);
                  }

                  final status = tripDates[dayNumber];
                  Color? backgroundColor;
                  Color textColor = const Color(0xFF111827);

                  if (status == 'completed') {
                    backgroundColor = const Color(0xFFD1FAE5);
                    textColor = const Color(0xFF065F46);
                  } else if (status == 'confirmed') {
                    backgroundColor = const Color(0xFFFFEDD5);
                    textColor = const Color(0xFF9A3412);
                  } else if (status == 'ongoing') {
                    backgroundColor = const Color(0xFFDBEAFE);
                    textColor = const Color(0xFF1E40AF);
                  }

                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '$dayNumber',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

// Legend Item Widget
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// Trip Card Widget
class _TripCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String status;
  final String location;
  final String dates;
  final String travelers;
  final String price;
  final String planner;

  const _TripCard({
    required this.imageUrl,
    required this.title,
    required this.status,
    required this.location,
    required this.dates,
    required this.travelers,
    required this.price,
    required this.planner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Title

          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Color(0xFF059669),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF6B7280),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xFF6B7280),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dates,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: Color(0xFF6B7280),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    travelers,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.attach_money,
                    color: Color(0xFF6B7280),
                    size: 16,
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Planner',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        planner,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF111827),
                      backgroundColor: Colors.grey.shade200,
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'View Trip',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
