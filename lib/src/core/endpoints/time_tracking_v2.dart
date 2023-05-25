import 'package:http/http.dart';

class ClickUpTimeTrackingV2 {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpTimeTrackingV2(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});
}
