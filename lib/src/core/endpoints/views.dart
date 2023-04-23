import 'package:http/http.dart';

class ClickUpViews {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpViews({required this.endPoint, required this.authToken, required this.httpClient});
}
