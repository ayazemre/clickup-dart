import 'package:http/http.dart';

class ClickUpUsers {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpUsers({required this.endPoint, required this.authToken, required this.httpClient});
}
