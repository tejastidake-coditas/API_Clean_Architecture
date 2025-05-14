class NetworkConstants {
  static const String baseUrl = 'https://dummyjson.com';
  static const String productEndpoint = '$baseUrl/products';
  static const String headerContentType = 'application/json';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration recieveTimeout = Duration(seconds: 10);
}
