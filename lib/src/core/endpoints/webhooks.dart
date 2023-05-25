import 'package:http/http.dart';

class ClickUpWebhooks {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpWebhooks(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});
}
