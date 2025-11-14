import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/validators.dart';
// DON'T import signin.dart - this is causing the crash

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();

  void _navigateToOtpVerification() {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    if (!Validators.isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    context.push('/otp-verification', extra: email);
  }

  // FIXED: Use named route navigation instead of direct widget import
  void _navigateToSignIn() {
    try {
      context.push('/signin');
    } catch (e) {
      print('Navigation error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to navigate to sign in page. Please try again.',
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
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
                      height: 40 / 32,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Create your account',
                    textAlign: TextAlign.center,
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
                  const SizedBox(height: 8),
                  const Text(
                    'Let\'s get you set up with your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF4B5563),
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 38),

                  // Social Login Buttons
                  _buildSocialButton(
                    'Continue with Google',
                    Colors.white,
                    Colors.black87,
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
                    SvgPicture.asset(
                      'assets/images/signup_icons/facebok.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(height: 32),

                  _buildOrDivider(),
                  const SizedBox(height: 32),

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
                  _buildEmailInputWithDivider(),
                  const SizedBox(height: 22),

                  // Continue Button
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      gradient: const LinearGradient(
                        begin: Alignment(-0.42, -0.91),
                        end: Alignment(0.42, 0.91),
                        stops: [-0.0421, 0.5145, 1.0712],
                        colors: [
                          Color(0xFF3B82F6),
                          Color(0xFF2563EB),
                          Color(0xFF1E40AF),
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: _navigateToOtpVerification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
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
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        height: 17.5 / 14,
                      ),
                      children: [
                        const TextSpan(
                          text: 'By continuing, you agree to our ',
                        ),
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 17.5 / 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Terms of Service tapped');
                            },
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 17.5 / 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Privacy Policy tapped');
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign In Link - FIXED to prevent crashes
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4B5563),
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w400,
                        height: 24 / 16,
                      ),
                      children: [
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontFamily: 'Instrument Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 24 / 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Sign In tapped - using named route');
                              _navigateToSignIn();
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),

                  Text(
                    'Version 1.0 (Build 457)',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(color: Color(0xFFF3F4F6)),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'or',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(color: Color(0xFFF3F4F6)),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailInputWithDivider() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.email_outlined, color: Colors.grey.shade400, size: 20),
          const SizedBox(width: 12),
          Container(
            width: 1,
            height: 24,
            decoration: const BoxDecoration(color: Color(0xFFD1D5DB)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Instrument Sans',
              ),
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Instrument Sans',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    String text,
    Color backgroundColor,
    Color textColor,
    Widget icon,
  ) {
    return Container(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // Handle social login
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF3F4F6),
          foregroundColor: Colors.black87,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
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
