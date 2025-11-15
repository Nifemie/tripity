import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditReviewSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final int initialRating;
  final String initialReview;

  const EditReviewSheet({
    super.key,
    required this.title,
    required this.subtitle,
    this.initialRating = 0,
    this.initialReview = '',
  });

  @override
  State<EditReviewSheet> createState() => _EditReviewSheetState();
}

class _EditReviewSheetState extends State<EditReviewSheet> {
  late int _selectedRating;
  late TextEditingController _reviewController;
  final int _maxCharacters = 500;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.initialRating;
    _reviewController = TextEditingController(text: widget.initialReview);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remainingCharacters = _maxCharacters - _reviewController.text.length;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edit Review',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3F4F6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, color: Color(0xFFF3F4F6)),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and subtitle
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Bookings/location.svg',
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF6B7280),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Rating
                    const Text(
                      'Rating',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRating = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.star,
                              size: 32,
                              color: index < _selectedRating
                                  ? const Color(0xFFFBBF24)
                                  : const Color(0xFFD1D5DB),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 24),

                    // Your Review
                    const Text(
                      'Your Review',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _reviewController,
                        maxLines: 5,
                        maxLength: _maxCharacters,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Share tour experience...',
                          hintStyle: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                          counterText: '',
                        ),
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$remainingCharacters characters remaining',
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Add Photos
                    GestureDetector(
                      onTap: () {
                        // Handle add photos
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                              color: Color(0xFF6B7280),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Add Photos (Optional)',
                              style: TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFFE5E7EB),
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF111827),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: _selectedRating > 0 &&
                                        _reviewController.text.isNotEmpty
                                    ? const LinearGradient(
                                        begin: Alignment(-0.04, -1.0),
                                        end: Alignment(1.07, 1.0),
                                        colors: [
                                          Color(0xFF3B82F6),
                                          Color(0xFF2563EB),
                                          Color(0xFF1E40AF),
                                        ],
                                        stops: [0.0, 0.5145, 1.0712],
                                      )
                                    : null,
                                color: _selectedRating > 0 &&
                                        _reviewController.text.isNotEmpty
                                    ? null
                                    : const Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: ElevatedButton(
                                onPressed: _selectedRating > 0 &&
                                        _reviewController.text.isNotEmpty
                                    ? () {
                                        Navigator.pop(context);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/Home/plane.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Send Reply',
                                      style: TextStyle(
                                        fontFamily: 'Instrument Sans',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
