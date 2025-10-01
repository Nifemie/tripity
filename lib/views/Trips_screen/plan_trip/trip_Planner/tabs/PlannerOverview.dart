import 'package:flutter/material.dart';

import 'package:tripitify/models/home_screen/trip_planner.dart';

class PlannerOverviewScreen extends StatelessWidget {
  final TripPlanner planner;

  const PlannerOverviewScreen({Key? key, required this.planner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About Section
            const SectionTitle(title: 'About'),
            const SizedBox(height: 8),
            Text(
              planner.about,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Experience Section
            const SectionTitle(title: 'Experience'),
            const SizedBox(height: 8),
            Text(
              planner.experience,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Destination Specialties Section
            const SectionTitle(title: 'Destination Specialties'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: planner.destinationSpecialties
                  .map((location) => DestinationChip(location: location))
                  .toList(),
            ),

            const SizedBox(height: 24),

            // Travel Expertise Section
            const SectionTitle(title: 'Travel Expertise'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: planner.travelExpertise
                  .map((expertise) => ExpertiseChip(text: expertise))
                  .toList(),
            ),

            const SizedBox(height: 24),

            // Languages Section
            const SectionTitle(title: 'Languages'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: planner.languages
                  .map((language) => LanguageItem(language: language))
                  .toList(),
            ),

            const SizedBox(height: 24),

            // Availability Section
            const SectionTitle(title: 'Availability'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                color: planner.isAcceptingClients ? const Color(0xFFDCFCE7) : Colors.red[100],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: planner.isAcceptingClients ? const Color(0xFF22C55E) : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    planner.isAcceptingClients ? 'Accepting Clients' : 'Not Accepting Clients',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: planner.isAcceptingClients ? const Color(0xFF22C55E) : Colors.red,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Instrument Sans',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111827),
        height: 1.5,
      ),
    );
  }
}

class DestinationChip extends StatelessWidget {
  final String location;

  const DestinationChip({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF3F4F6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 16,
            color: Color(0xFF6B7280),
          ),
          const SizedBox(width: 6),
          Text(
            location,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpertiseChip extends StatelessWidget {
  final String text;

  const ExpertiseChip({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF3F4F6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Instrument Sans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF374151),
          height: 1.5,
        ),
      ),
    );
  }
}

class LanguageItem extends StatelessWidget {
  final String language;

  const LanguageItem({
    Key? key,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.language,
          size: 20,
          color: Color(0xFF6B7280),
        ),
        const SizedBox(width: 8),
        Text(
          language,
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

