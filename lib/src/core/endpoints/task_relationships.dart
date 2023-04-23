import 'package:http/http.dart';

class ClickUpTaskRelationships {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpTaskRelationships({required this.endPoint, required this.authToken, required this.httpClient});
}
