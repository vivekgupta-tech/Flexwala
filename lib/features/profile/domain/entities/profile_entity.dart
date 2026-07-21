class ProfileEntity {
  final String id;
  final String fullName;
  final String mobile;
  final String? email;
  final String? businessName;
  final String? businessShortName;
  final String? businessMobile;
  final String? businessWhatsappNo;
  final String? businessAdharNo;
  final String? businessPan;
  final String? businessAddress;
  final String? customerImage;

  const ProfileEntity({
    required this.id,
    required this.fullName,
    required this.mobile,
    this.email,
    this.businessName,
    this.businessShortName,
    this.businessMobile,
    this.businessWhatsappNo,
    this.businessAdharNo,
    this.businessPan,
    this.businessAddress,
    this.customerImage,
  });
}
