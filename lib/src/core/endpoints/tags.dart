import 'package:http/http.dart';

class ClickUpTags {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpTags({required this.endPoint, required this.authToken, required this.httpClient});
}
