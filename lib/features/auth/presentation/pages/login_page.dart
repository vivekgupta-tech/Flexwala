import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexwala/core/navigation/app_router.dart';
import 'package:flexwala/core/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _mobileCtrl = TextEditingController();

  @override
  void dispose() {
    _mobileCtrl.dispose();
    super.dispose();
  }

  String? _validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) return 'Mobile number required';
    if (value.trim().length != 10) return 'Enter a valid 10-digit mobile number';
    return null;
  }

  void _onSendOtp() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SendOtpRequested(mobile: _mobileCtrl.text.trim()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpSent) {
            Navigator.of(context).pushNamed(
              AppRoutes.verifyOtp,
              arguments: state.mobile,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header with Gradient and Logo
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: AppColors.brandGradientDiagonal,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/logopng.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Flexwala',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Text(
                        'Design Your Dreams',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Please enter your mobile number to get an OTP.',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Mobile Input field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: TextFormField(
                            controller: _mobileCtrl,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            enabled: !isLoading,
                            validator: _validateMobile,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                              prefixIcon: const Icon(Icons.phone_android_rounded, color: AppColors.primaryPurple),
                              prefixText: '+91 ',
                              prefixStyle: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              counterText: "",
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Send OTP Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.brandGradient,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryPurple.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _onSendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Send OTP',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'By continuing, you agree to our ',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                              children: const [
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(
                                    color: AppColors.primaryPurple,
                                    fontWeight: FontWeight.bold,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
