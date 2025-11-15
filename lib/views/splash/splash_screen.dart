import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _lineController;
  late AnimationController _fadeController;

  late Animation<double> _lineAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _lineController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Create animations
    _lineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _lineController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Start line animation
    await _lineController.forward();

    // Start fade in for text
    await _fadeController.forward();

    // Wait a bit then navigate to next screen
    await Future.delayed(const Duration(seconds: 5));

    if (mounted) {
      // context.push('/intro');
      context.push('/HomeScreen');
    }
  }

  @override
  void dispose() {
    _lineController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Top spacing
              const Spacer(flex: 2),

              // Animated vector line and static plane
              Expanded(
                flex: 3,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Vector line with animation - positioned lower and more to the left
                      Transform.translate(
                        offset: const Offset(
                            -100, 60), // Moved further left and down more
                        child: AnimatedBuilder(
                          animation: _lineAnimation,
                          builder: (context, child) {
                            return ClipPath(
                              clipper: LineClipper(_lineAnimation.value),
                              child: SvgPicture.asset(
                                'assets/images/Vector.svg',
                                width: 120,
                                height: 120,
                                alignment: Alignment.centerLeft,
                                colorFilter: ColorFilter.mode(
                                  const Color(0xFFDBEAFE), // Primary Blue 100
                                  BlendMode.srcIn,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Static plane logo - positioned higher and more to the right to be at end of path
                      Transform.translate(
                        offset: const Offset(
                            30, -10), // Moved right and up to be at path end
                        child: Image.asset(
                          'assets/images/splashplane.png',
                          width: 80,
                          height: 80,
                          color: const Color(0xFF4A90E2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // App name and tagline with fade animation
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      children: [
                        const Text(
                          'tripitify',
                          style: TextStyle(
                            color: Color(0xFF3B82F6), // Primary Blue 500
                            fontFamily: 'Velocity',
                            fontSize: 48,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 56 / 48,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Tagline
                        const Text(
                          'Your perfect trip, planned your way',
                          style: TextStyle(
                            color: Color(0xFF4B5563), // Text Secondary
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 1.0, // normal line-height
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Bottom spacing and version
              const Spacer(flex: 2),

              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value * 0.6,
                    child: const Text(
                      'Version 1.0 (Build 457)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom clipper for animating the vector line
class LineClipper extends CustomClipper<Path> {
  final double animationValue;

  LineClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();

    // This creates a reveal effect for the line
    // You might need to adjust this based on your actual vector line shape
    final width = size.width * animationValue;
    path.addRect(Rect.fromLTWH(0, 0, width, size.height));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
