import 'package:http/http.dart';

class ClickUpLists {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpLists({required this.endPoint, required this.authToken, required this.httpClient});
}
