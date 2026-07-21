import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.fullName,
    required super.mobile,
    super.email,
    super.businessName,
    super.businessShortName,
    super.businessMobile,
    super.businessWhatsappNo,
    super.businessAdharNo,
    super.businessPan,
    super.businessAddress,
    super.customerImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['cust_id'].toString(),
      fullName: json['full_name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'],
      businessName: json['business_name'],
      businessShortName: json['business_short_name'],
      businessMobile: json['business_mobile'],
      businessWhatsappNo: json['business_whatsapp_no'],
      businessAdharNo: json['business_adhar_no'],
      businessPan: json['business_pan'],
      businessAddress: json['business_adress'], // Note: API spelled it 'business_adress'
      customerImage: json['customer_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cust_id': id,
      'full_name': fullName,
      'mobile': mobile,
      'email': email,
      'business_name': businessName,
      'business_short_name': businessShortName,
      'business_mobile': businessMobile,
      'business_whatsapp_no': businessWhatsappNo,
      'business_adhar_no': businessAdharNo,
      'business_pan': businessPan,
      'business_adress': businessAddress,
      'customer_image': customerImage,
    };
  }
}
