import 'package:flutter/material.dart';
import 'package:tripitify/models/home_screen/experience.dart';

class ExperiencesSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperiencesSection({Key? key, required this.experiences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Experiences, Stays & More",
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Explore trusted services for a seamless trip.",
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF3B82F6)),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 420, // Adjusted height for the new card layout
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: experiences.length,
            padding: const EdgeInsets.only(right: 16),
            itemBuilder: (context, index) {
              return ExperienceCard(experience: experiences[index]);
            },
          ),
        ),
      ],
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final Experience experience;

  const ExperienceCard({Key? key, required this.experience}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.asset(
              experience.imagePath,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.favorite_border, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndRating(),
          const SizedBox(height: 8),
          Text(
            experience.description,
            style: const TextStyle(fontFamily: 'Instrument Sans', fontSize: 14, color: Color(0xFF6B7280)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          _buildInfoRows(),
          const SizedBox(height: 12),
          _buildTags(),
          const Spacer(),
          _buildPrice(),
          const SizedBox(height: 16),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildTitleAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            experience.title,
            style: const TextStyle(fontFamily: 'Instrument Sans', fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Color(0xFFFBBF24), size: 16),
            const SizedBox(width: 4),
            Text(
              experience.rating.toString(),
              style: const TextStyle(fontFamily: 'Instrument Sans', fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF111827)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRows() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_outlined, color: Color(0xFF6B7280), size: 14),
            const SizedBox(width: 4),
            Text(experience.location, style: const TextStyle(fontFamily: 'Instrument Sans', fontSize: 12, color: Color(0xFF6B7280))),
            const SizedBox(width: 12),
            const Icon(Icons.rate_review_outlined, color: Color(0xFF6B7280), size: 14),
            const SizedBox(width: 4),
            Text('${experience.reviewCount} Reviews', style: const TextStyle(fontFamily: 'Instrument Sans', fontSize: 12, color: Color(0xFF6B7280))),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.directions_walk_outlined, color: Color(0xFF6B7280), size: 14),
            const SizedBox(width: 4),
            Text(experience.distance, style: const TextStyle(fontFamily: 'Instrument Sans', fontSize: 12, color: Color(0xFF6B7280))),
          ],
        ),
      ],
    );
  }

  Widget _buildTags() {
    return Row(
      children: [
        ...experience.tags.take(2).map((tag) => _buildTag(tag)),
        if (experience.tags.length > 2)
          _buildTag('+${experience.tags.length - 2}'),
      ],
    );
  }

  Widget _buildTag(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(label, style: const TextStyle(fontFamily: 'Instrument Sans', fontSize: 12, color: Color(0xFF4B5563))),
    );
  }

  Widget _buildPrice() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontFamily: 'Instrument Sans', fontSize: 16, color: Color(0xFF111827)),
        children: [
          TextSpan(text: 'From \${experience.price}', style: const TextStyle(fontWeight: FontWeight.w600)),
          const TextSpan(text: '/night', style: TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('View Details', style: TextStyle(fontFamily: 'Instrument Sans', fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF374151))),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
              elevation: 0,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB), Color(0xFF1E40AF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text('Book Now', style: TextStyle(fontFamily: 'Instrument Sans', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
