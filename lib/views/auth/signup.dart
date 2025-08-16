import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'tripitify',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontFamily: 'Velocity',
                    fontSize: 32,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    height: 40 / 32, // 125%
                  ),
                ),

                const SizedBox(height: 48),

                // Title
                const Text(
                  'Create your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontFamily: 'Instrument Sans',
                    fontSize: 24,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    height: 33 / 24, // 137.5%
                    letterSpacing: 0,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Let\'s get you set up with your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16, // 150%
                  ),
                ),

                const SizedBox(height: 48),

                // Social Login Buttons
                _buildSocialButton(
                  'Continue with Google',
                  Colors.white,
                  Colors.black87,
                  // Replace 'assets/images/google_icon.png' with your actual Google icon path
                  Image.asset(
                    'assets/images/signup_icons/google.png',
                    width: 24,
                    height: 24,
                  ),
                ),

                const SizedBox(height: 16),

                _buildSocialButton(
                  'Continue with Apple',
                  Colors.white,
                  Colors.black87,
                  // Replace 'assets/images/apple_icon.png' with your actual Apple icon path
                  Image.asset(
                    'assets/images/signup_icons/apple.png',
                    width: 24,
                    height: 24,
                  ),
                ),

                const SizedBox(height: 16),

                _buildSocialButton(
                  'Continue with Facebook',
                  Colors.white,
                  Colors.black87,
                  // Replace 'assets/images/facebook_icon.svg' with your actual Facebook SVG path
                  SvgPicture.asset(
                    'assets/images/signup_icons/facebok.svg',
                    width: 24,
                    height: 24,
                  ),
                ),

                const SizedBox(height: 32),

                // Divider
                const Text(
                  'or',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 32),

                // Email Section
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Email Input
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey.shade400,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle continue action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4285F4),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Terms and Privacy
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    children: [
                      const TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sign In Link
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    children: [
                      const TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Version Info
                Text(
                  'Version 1.0 (Build 457)',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, Color backgroundColor, Color textColor, Widget icon) {
    return Container(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // Handle social login
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF3F4F6), // Gray 100
          foregroundColor: Colors.black87,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999), // Full border radius
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}