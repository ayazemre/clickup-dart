import 'package:http/http.dart';

class ClickUpSharedHierarchy {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpSharedHierarchy({required this.endPoint, required this.authToken, required this.httpClient});
}
