import 'package:http/http.dart';

class ClickUpTimeTrackingLegacy {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpTimeTrackingLegacy({required this.endPoint, required this.authToken, required this.httpClient});
}
