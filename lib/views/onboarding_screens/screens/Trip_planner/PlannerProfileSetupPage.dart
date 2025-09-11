import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripitify/widgets/progress_bar.dart';
import 'package:tripitify/providers/progress_provider.dart';
import 'package:go_router/go_router.dart';

// Providers

final destinationSpecialtiesProvider = StateProvider<String>((ref) => '');
final yearsOfExperienceProvider = StateProvider<String?>((ref) => null);
final customYearsProvider = StateProvider<String>((ref) => '');
final selectedRateProvider = StateProvider<String?>((ref) => null);
final customRateProvider = StateProvider<String>((ref) => '');

class PlannerProfileSetupPage extends ConsumerWidget {
  const PlannerProfileSetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            ref.read(progressProvider.notifier).decrement();
            context.pop();
          },
        ),
        title: Text(
          'Account setup',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 27.5 / 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ProgressBar(
              currentStep: progressState.currentStep,
              totalSteps: progressState.totalSteps,
            ),
          ),
          const SizedBox(height: 32),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildSubtitle(),
                  const SizedBox(height: 32),
                  _buildDestinationSpecialties(ref),
                  const SizedBox(height: 24),
                  _buildYearsOfExperience(ref),
                  const SizedBox(height: 24),
                  _buildChooseRate(ref),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Continue Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: _buildContinueButton(context, ref),
          ),
        ],
      ),
    );
  }

  

  Widget _buildTitle() {
    return Text(
      'Let\'s set up your planner profile',
      style: TextStyle(
        color: Color(0xFF111827),
        fontFamily: 'Instrument Sans',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 27.5 / 20,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Tell us what kind of trips you specialize in and what clients can expect.',
      style: TextStyle(
        color: Color(0xFF4B5563),
        fontFamily: 'Instrument Sans',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 21 / 14,
      ),
    );
  }

  Widget _buildDestinationSpecialties(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Destination Specialties (e.g. Paris, Kenya)',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 21 / 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFD1D5DB)),
            color: Color(0xFFF9FAFB),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/Home/calender.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              Container(
                width: 1,
                height: 24,
                color: const Color(0xFFD1D5DB),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Choose from list or type custom',
                    hintStyle: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => ref.read(destinationSpecialtiesProvider.notifier).state = value,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Color(0xFF9CA3AF)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildYearsOfExperience(WidgetRef ref) {
    final selectedYears = ref.watch(yearsOfExperienceProvider);
    final customYears = ref.watch(customYearsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Years of Planning Experience',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 21 / 14,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: ['1+', '2+', '3+', '4+'].map((years) {
            final isSelected = selectedYears == years;
            return Expanded(
              child: GestureDetector(
                onTap: () => ref.read(yearsOfExperienceProvider.notifier).state = years,
                child: Container(
                  height: 52,
                  margin: EdgeInsets.only(
                    right: years != '4+' ? 8 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? Color(0xFF3B82F6) : Color(0xFFF3F4F6),
                  ),
                  child: Center(
                    child: Text(
                      years,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 17.5 / 14,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Container(
          height: 52,
          padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFD1D5DB)),
            color: Color(0xFFF9FAFB),
          ),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Enter no. of years',
              hintStyle: TextStyle(
                color: Color(0xFF9CA3AF),
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => ref.read(customYearsProvider.notifier).state = value,
          ),
        ),
      ],
    );
  }

  Widget _buildChooseRate(WidgetRef ref) {
    final selectedRate = ref.watch(selectedRateProvider);
    final customRate = ref.watch(customRateProvider);

    final rates = ['\$15', '\$30', '\$25', '\$45', '\$60', '\$75', '\$90', '\$100'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Rate (e.g. \$50 per trip planning)',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 21 / 14,
          ),
        ),
        const SizedBox(height: 12),
        // First row of rates
        Row(
          children: rates.take(4).map((rate) {
            final isSelected = selectedRate == rate;
            return Expanded(
              child: GestureDetector(
                onTap: () => ref.read(selectedRateProvider.notifier).state = rate,
                child: Container(
                  height: 52,
                  margin: EdgeInsets.only(
                    right: rate != rates[3] ? 8 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? Color(0xFF3B82F6) : Color(0xFFF3F4F6),
                  ),
                  child: Center(
                    child: Text(
                      rate,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 17.5 / 14,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        // Second row of rates
        Row(
          children: rates.skip(4).map((rate) {
            final isSelected = selectedRate == rate;
            return Expanded(
              child: GestureDetector(
                onTap: () => ref.read(selectedRateProvider.notifier).state = rate,
                child: Container(
                  height: 52,
                  margin: EdgeInsets.only(
                    right: rate != rates.last ? 8 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? Color(0xFF3B82F6) : Color(0xFFF3F4F6),
                  ),
                  child: Center(
                    child: Text(
                      rate,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 17.5 / 14,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Container(
          height: 52,
          padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFD1D5DB)),
            color: Color(0xFFF9FAFB),
          ),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Enter no. of years',
              hintStyle: TextStyle(
                color: Color(0xFF9CA3AF),
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => ref.read(customYearsProvider.notifier).state = value,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context, WidgetRef ref) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
        gradient: LinearGradient(
          begin: Alignment(-0.0421, -1.0),
          end: Alignment(1.0712, 1.0),
          colors: [
            Color(0xFF3B82F6), // Primary Blue 500
            Color(0xFF2563EB), // Primary Blue 600
            Color(0xFF1E40AF), // Primary Blue 800
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          ref.read(progressProvider.notifier).increment();
          Navigator.pushNamed(context, '/planner-travel-preferences');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}