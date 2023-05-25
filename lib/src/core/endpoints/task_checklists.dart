import 'package:http/http.dart';

class ClickUpTaskChecklists {
  late String endPoint;
  late String authToken;
  late Client httpClient;
  ClickUpTaskChecklists(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});
}
