import 'package:http/http.dart';

class ClickUpTaskTemplates {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpTaskTemplates({required this.endPoint, required this.authToken, required this.httpClient});
}
