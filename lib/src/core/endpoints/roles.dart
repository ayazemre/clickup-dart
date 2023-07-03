import 'package:http/http.dart';

class ClickUpRoles {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpRoles(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});
}
