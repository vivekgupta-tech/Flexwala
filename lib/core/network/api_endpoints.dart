class ApiEndpoints {
  // Base URL ke peeche / lagayein
  static const String baseUrl = 'https://105106.in/flexwala/';
  
  // Endpoints ke aage se / hata dein
  static const String sendOtp = 'admin/send-otp';
  static const String verifyOtp = 'admin/verify-otp';

  static const String login = 'auth/login';
  static const String refreshToken = 'auth/refresh';
  static const String getProfile = 'admin/customers';
  static const String getCategories = 'admin/categories/all';
  static const String getSubCategories = 'admin/subcategories/all';
  static const String getChildCategories = 'admin/childcategories/all';
}
