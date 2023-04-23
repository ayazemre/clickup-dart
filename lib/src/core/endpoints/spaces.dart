import 'dart:convert';

import 'package:clickup_dart_sdk/src/core/clickup_exception.dart';
import 'package:http/http.dart';

class ClickUpSpaces {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpSpaces({required this.endPoint, required this.authToken, required this.httpClient});

  final Map<String, dynamic> sampleSpaceSchema = {
    "name": "Test Space",
    "multiple_assignees": false,
    "features": {
      "due_dates": {
        "enabled": false,
        "start_date": false,
        "remap_due_dates": false,
        "remap_closed_due_date": false
      },
      "time_tracking": {
        "enabled": false
      },
      "tags": {
        "enabled": false
      },
      "time_estimates": {
        "enabled": false
      },
      "checklists": {
        "enabled": false
      },
      "custom_fields": {
        "enabled": false
      },
      "remap_dependencies": {
        "enabled": false
      },
      "dependency_warning": {
        "enabled": false
      },
      "portfolios": {
        "enabled": false
      },
    }
  };

  Future<Map<String, dynamic>> getSpaces({required double teamID, bool includeArchived = false}) async {
    try {
      final response = await httpClient.get(Uri.parse(includeArchived ? "$endPoint/team/$teamID/space?archived=true" : "$endPoint/team/$teamID/space"), headers: {
        "Authorization": authToken,
      });
      final spaces = jsonDecode(response.body);
      return spaces;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> createSpace({required double teamID, required Map<String, dynamic> spaceSchema}) async {
    bool schemaMatch = false;
    for (var key in spaceSchema.keys) {
      schemaMatch = sampleSpaceSchema.containsKey(key);
      if (!schemaMatch) {
        break;
      }
    }

    if (!schemaMatch) {
      throw ClickUpException(exceptionType: ClickUpExceptionType.invalidModel, exceptionMessage: "Your value model is invalid. Please read the function documentation.");
    }

    try {
      final response = await httpClient.post(Uri.parse("$endPoint/team/$teamID/space"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(spaceSchema));
      final space = jsonDecode(response.body);
      return space;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> getSpace({required double spaceID}) async {
    try {
      final response = await httpClient.get(Uri.parse("$endPoint/space/$spaceID"), headers: {
        "Authorization": authToken,
      });
      final space = jsonDecode(response.body);
      return space;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> updateSpace({required double spaceID, required Map<String, dynamic> spaceSchema}) async {
    bool schemaMatch = false;
    schemaMatch = spaceSchema.containsKey("color");
    schemaMatch = spaceSchema.containsKey("private");
    schemaMatch = spaceSchema.containsKey("admin_can_manage");
    for (var key in spaceSchema.keys) {
      if (key != "color" && key != "private" && key != "admin_can_manage") {
        schemaMatch = sampleSpaceSchema.containsKey(key);
      }
      if (!schemaMatch) {
        break;
      }
    }
    if (!schemaMatch) {
      throw ClickUpException(exceptionType: ClickUpExceptionType.invalidModel, exceptionMessage: "Your value model is invalid. Please read the function documentation.");
    }
    try {
      final response = await httpClient.put(Uri.parse("$endPoint/space/$spaceID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(spaceSchema));
      final folders = jsonDecode(response.body);
      return folders;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> deleteSpace({required double spaceID}) async {
    try {
      final response = await httpClient.delete(Uri.parse("$endPoint/folder/$spaceID"), headers: {
        "Authorization": authToken,
      });
      final folders = jsonDecode(response.body);
      return folders;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
