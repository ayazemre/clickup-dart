import 'package:http/http.dart';

class ClickUpMembers {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpMembers(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});
}
