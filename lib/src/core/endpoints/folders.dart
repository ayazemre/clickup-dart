import 'dart:convert';

import 'package:clickup_dart_sdk/src/core/clickup_exception.dart';
import 'package:http/http.dart';

class ClickUpFolders {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpFolders({required this.endPoint, required this.authToken, required this.httpClient});

  Future<Map<String, dynamic>> getFolders({required double spaceID, bool includeArchived = false}) async {
    try {
      final response = await httpClient.get(Uri.parse(includeArchived ? "$endPoint/space/$spaceID/folder?archived=true" : "$endPoint/space/$spaceID/folder"), headers: {
        "Authorization": authToken,
      });
      final folders = jsonDecode(response.body);
      return folders;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> createFolder({required double spaceID, required String name}) async {
    try {
      final response = await httpClient.post(Uri.parse("$endPoint/space/$spaceID/folder"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": name
          }));
      final folder = jsonDecode(response.body);
      return folder;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> getFolder({required double folderID}) async {
    try {
      final response = await httpClient.get(Uri.parse("$endPoint/folder/$folderID"), headers: {
        "Authorization": authToken,
      });
      final folder = jsonDecode(response.body);
      return folder;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> updateFolder({required double folderID, required String name}) async {
    try {
      final response = await httpClient.put(Uri.parse("$endPoint/folder/$folderID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": name
          }));
      final folders = jsonDecode(response.body);
      return folders;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> deleteFolder({required double folderID}) async {
    try {
      final response = await httpClient.delete(Uri.parse("$endPoint/folder/$folderID"), headers: {
        "Authorization": authToken,
        "Content-Type": "application/json"
      });
      final folders = jsonDecode(response.body);
      return folders;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
