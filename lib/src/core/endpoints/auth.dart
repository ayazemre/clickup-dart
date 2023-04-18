import 'dart:convert';
import 'package:http/http.dart';

class ClickUpAuth {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpAuth({required this.endPoint, required this.authToken, required this.httpClient});

  /// Get access token based on your credentials.
  // Future<String> getAccessToken(
  //     {required String clientID,
  //     required String clientSecret,
  //     required String code}) async {
  //   try {
  //     final response = await post(Uri.parse(
  //         "$endPoint/oauth/token?client_id=$clientID&client_secret=$clientSecret&code=$code"));
  //     print(response.body);
  //     return response.body;
  //   } catch (e) {
  //     print(e.toString());
  //     return e.toString();
  //   }
  // }

  /// Get the user bound to the token.
  Future<Map<String, dynamic>> getAuthorizedUser() async {
    try {
      final response = await httpClient.get(Uri.parse("$endPoint/user"), headers: {
        "Authorization": authToken
      });
      final user = jsonDecode(response.body);
      return user;
    } catch (e) {
      print(e.toString());
      return {
        "error": "$e"
      };
    }
  }

  /// Get the teams bound to authorized user.
  Future<Map<String, dynamic>> getAuthorizedTeams() async {
    try {
      final response = await httpClient.get(Uri.parse("$endPoint/team"), headers: {
        "Authorization": authToken
      });
      final teams = jsonDecode(response.body);
      return teams;
    } catch (e) {
      print(e.toString());
      return {
        "error": "$e"
      };
    }
  }
}
