import 'package:http/http.dart';

class ClickUpGoals {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpGoals({required this.endPoint, required this.authToken, required this.httpClient});
}
