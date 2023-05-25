import 'package:http/http.dart';

class ClickUpGuests {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpGuests(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});
}
