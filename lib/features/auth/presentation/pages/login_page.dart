import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _otpCtrl = TextEditingController();
  bool _isOtpSent = false;

  @override
  void dispose() {
    _mobileCtrl.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  String? _validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) return 'Mobile number required';
    if (value.trim().length != 10) return 'Enter a valid 10-digit mobile number';
    return null;
  }

  String? _validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) return 'OTP required';
    if (value.trim().length < 4) return 'Enter a valid OTP';
    return null;
  }

  void _onSendOtp() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SendOtpRequested(mobile: _mobileCtrl.text.trim()),
          );
    }
  }

  void _onVerifyOtp() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            VerifyOtpRequested(
              mobile: _mobileCtrl.text.trim(),
              otp: _otpCtrl.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpSent) {
              setState(() {
                _isOtpSent = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('OTP sent successfully')),
              );
            } else if (state is AuthSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _isOtpSent ? 'Verify OTP' : 'Login with Mobile',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _mobileCtrl,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        enabled: !isLoading && !_isOtpSent,
                        validator: _validateMobile,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          prefixIcon: Icon(Icons.phone_android),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      if (_isOtpSent) ...[
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _otpCtrl,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          enabled: !isLoading,
                          validator: _validateOtp,
                          onFieldSubmitted: (_) => _onVerifyOtp(),
                          decoration: const InputDecoration(
                            labelText: 'OTP',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : (_isOtpSent ? _onVerifyOtp : _onSendOtp),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(_isOtpSent ? 'Verify OTP' : 'Send OTP'),
                      ),
                      if (_isOtpSent)
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  setState(() {
                                    _isOtpSent = false;
                                    _otpCtrl.clear();
                                  });
                                },
                          child: const Text('Change Mobile Number'),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
