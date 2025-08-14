import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  bool _showGetStartedButton = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Show location dialog after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _showLocationDialog();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showLocationDialog() {
    _animationController.forward();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder:
          (context) => SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Blue dot indicator
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 16, color: Color(0xFF111827)),
                  children: [
                    TextSpan(text: 'Allow '),
                    TextSpan(
                      text: 'Tripitify',
                      style: TextStyle(
                        color: Color(0xFF3B82F6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: ' access this device location?'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _handleLocationPermission(true),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF3B82F6),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'While using the app',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _handleLocationPermission(false),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF3B82F6),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Only this time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _handleLocationPermission(null),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF6B7280),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Don\'t allow',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
      ),
    );
  }

  void _handleLocationPermission(bool? allowLocation) async {
    Navigator.of(context).pop(); // Close the dialog

    if (allowLocation == true) {
      // Request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // Permission granted
        print("Location permission granted");
      }
    }

    // Show the "Get Started" button immediately after location dialog is closed
    setState(() {
      _showGetStartedButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              children: [
              // Top spacing
              const SizedBox(height: 30),

          // Image section
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(
                'assets/images/intro.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 2),

          // Content section
          Expanded(
            flex: 2,
            child: Column(
              children: [
            // Text content moved closer to image
            Column(
            children: [
            const Align(
            alignment: Alignment.centerLeft,
              child: Text(
                'Plan Smarter. Travel Better with',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontFamily: 'Instrument Sans',
                  fontSize: 24,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 33 / 24,
                  letterSpacing: 0,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tripitify.',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontFamily: 'Instrument Sans',
                  fontSize: 24,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 33 / 24,
                  letterSpacing: 0,
                ),
              ),
            ),
            ],
          ),

          const SizedBox(height: 16),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ' Planning a short trip or starting fresh in a new place? ',
              style: TextStyle(
                color: Color(0xFF4B5563),
                fontFamily: 'Instrument Sans',
                fontSize: 15,
                fontStyle: FontStyle.normal,
                height: 33 / 24,
                letterSpacing: 0,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
                ' Were here to make it easy, personalized, organized,',
                style: TextStyle(
                color: Color(0xFF4B5563),
            fontFamily: 'Instrument Sans',
            fontSize: 15,
            fontStyle: FontStyle.normal,
            height: 33 / 24,
            letterSpacing: 0,
          ),
        ),
      ),

      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'and stress-free.',
          style: TextStyle(
            color: Color(0xFF4B5563),
            fontFamily: 'Instrument Sans',
            fontSize: 15,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),

      const Spacer(),
      ],
    ),
    ),

    // Get Started Button with gradient background
    AnimatedOpacity(
    opacity: _showGetStartedButton ? 1.0 : 0.0,
    duration: const Duration(milliseconds: 300),
    child: Container(
    width: double.infinity,
    height: 52,
    margin: const EdgeInsets.only(bottom: 40),
    decoration: BoxDecoration(
    gradient: const LinearGradient(
    begin: Alignment(-0.1, -0.5),
    end: Alignment(1.1, 0.5),
    colors: [
    Color(0xFF3B82F6), // Primary Blue 500
    Color(0xFF2563EB), // Primary Blue 600
    Color(0xFF1E40AF), // Primary Blue 800
    ],
    stops: [0.0, 0.51, 1.0],
    ),
    borderRadius: BorderRadius.circular(
    9999,
    ), // Full border radius
    ),
    child: ElevatedButton(
    onPressed:
    _showGetStartedButton
    ? () {
    // Navigate to next screen
    // Navigator.pushReplacementNamed(context, '/home');
    }
        : null,
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(9999),
    ),
    ),
    child: const Text(
    'Get Started',
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    ),
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    );
  }
}