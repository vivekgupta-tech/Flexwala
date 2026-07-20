import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SendOtpRequested extends AuthEvent {
  final String mobile;
  const SendOtpRequested({required this.mobile});
  @override
  List<Object?> get props => [mobile];
}

class VerifyOtpRequested extends AuthEvent {
  final String mobile;
  final String otp;
  const VerifyOtpRequested({required this.mobile, required this.otp});
  @override
  List<Object?> get props => [mobile, otp];
}
