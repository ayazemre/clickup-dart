import 'package:http/http.dart';

class ClickUpTasks {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpTasks({required this.endPoint, required this.authToken, required this.httpClient});
}
