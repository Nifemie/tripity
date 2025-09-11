import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement forgot password logic with Riverpod
      // Example: ref.read(authProvider.notifier).sendPasswordReset(_emailController.text);

      // For now, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent!'),
          backgroundColor: Color(0xFF3B82F6),
        ),
      );
    }
  }

  void _backToSignIn() {
    context.go('/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: GestureDetector(
                  onTap: _backToSignIn,
                  child: Container(
                    width: 24,
                    height: 24,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: Color(0xFF111827),
                    ),
                    // TODO: Replace with your SVG icon
                    // SvgPicture.asset(
                    //   'assets/icons/back_arrow.svg',
                    //   width: 24,
                    //   height: 24,
                    // ),
                  ),
                ),
              ),

              const SizedBox(height: 100),

              // Tripitify logo text
              Center(
                child: Text(
                  'tripitify',
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontFamily: 'Velocity',
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    height: 40 / 32, // line-height / font-size
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // Add bottom padding for scroll
              const SizedBox(height: 40),

              // Trouble signing in? title
              Center(
                child: Text(
                  'Trouble signing in?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF111827),
                    fontFamily: 'Instrument Sans',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 33 / 24, // line-height / font-size
                    letterSpacing: 0,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Description text
              Center(
                child: Text(
                  'Enter the email associated with your account and\nwe\'ll send you a link to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontFamily: 'Instrument Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16, // line-height / font-size
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Email input form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email label
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Email input field
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 1,
                        ),
                        color: const Color(0xFFF9FAFB),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email address',
                          hintStyle: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontFamily: 'Instrument Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF6B7280),
                              size: 20,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Send Reset Link button
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.0421, -1.0),
                    end: Alignment(1.0712, 1.0),
                    colors: [
                      Color(0xFF3B82F6), // Primary-Blue-500
                      Color(0xFF2563EB), // Primary-Blue-600
                      Color(0xFF1E40AF), // Primary-Blue-800
                    ],
                    stops: [-0.0421, 0.5145, 1.0712],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(9999),
                  child: InkWell(
                    onTap: _sendResetLink,
                    borderRadius: BorderRadius.circular(9999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      alignment: Alignment.center,
                      child: const Text(
                        'Send Reset Link',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 24 / 16, // line-height / font-size
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Back to Sign In link
              Center(
                child: GestureDetector(
                  onTap: _backToSignIn,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF2563EB),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Back to Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF2563EB),
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 24 / 16, // line-height / font-size
                        ),
                      ),
                    ],
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