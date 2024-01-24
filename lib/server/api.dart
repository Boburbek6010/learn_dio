class ApiServer{
  static const String baseUrl = "https://6554a27063cafc694fe6bbeb.mockapi.io";
  static const String apiGetAllData = "/asdas";
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  static const Map<String, String> headers = {"Content-Type": "application/json"};
}