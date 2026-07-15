
class ApiEndpoints {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://dev-api.example.com',
  );
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh';
}

