class OtpResponseModel {
  final bool success;
  final String message;
  final OtpData? data;

  OtpResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? OtpData.fromJson(json['data']) : null,
    );
  }
}

class OtpData {
  final String mobile;
  final int otp;
  final String expiresAt;

  OtpData({
    required this.mobile,
    required this.otp,
    required this.expiresAt,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      mobile: json['mobile'].toString(),
      otp: json['otp'] is int ? json['otp'] : int.parse(json['otp'].toString()),
      expiresAt: json['expires_at'] ?? '',
    );
  }
}
