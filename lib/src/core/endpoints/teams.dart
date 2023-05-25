import 'package:http/http.dart';

class ClickUpTeams {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpTeams({required this.endPoint, required this.authToken, required this.httpClient});
}
