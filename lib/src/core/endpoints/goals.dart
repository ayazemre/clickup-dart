import 'dart:convert';

import 'package:http/http.dart';

import '../clickup_exception.dart';

class ClickUpGoals {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpGoals({required this.endPoint, required this.authToken, required this.httpClient});

  /// View the Goals available in a Workspace.

  Future<Map<String, dynamic>> getGoals({required double teamID, bool includeCompleted = false}) async {
    try {
      final response = await httpClient.get(Uri.parse(includeCompleted ? "$endPoint/team/$teamID/goal?include_completed=true" : "$endPoint/team/$teamID/goal"), headers: {
        "Authorization": authToken,
      });
      final goals = jsonDecode(response.body);
      return goals;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Add a new Goal to a Workspace.

  Future<Map<String, dynamic>> createGoal({required double teamID, required String goalName, required int dueDate, required String description, required bool multipleOwners, required List<int> owners, required String color}) async {
    try {
      final response = await httpClient.post(Uri.parse("$endPoint/team/$teamID/goal"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": goalName,
            "due_date": dueDate,
            "description": description,
            "multiple_owners": multipleOwners,
            "owners": owners,
            "color": color
          }));
      final goal = jsonDecode(response.body);
      return goal;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// View the details of a Goal including its Targets.
  ///
  /// Goal ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``

  Future<Map<String, dynamic>> getGoal({required double goalID}) async {
    try {
      final response = await httpClient.get(Uri.parse("$endPoint/goal/$goalID"), headers: {
        "Authorization": authToken,
      });
      final goal = jsonDecode(response.body);
      return goal;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Rename a Goal, set the due date, replace the description, add or remove owners, and set the Goal color.
  ///
  /// Goal ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``
  Future<Map<String, dynamic>> updateGoal({required double goalID, required String goalName, required int dueDate, required String description, required List<int> ownersToRemove, required List<int> ownersToAdd, required String color}) async {
    try {
      final response = await httpClient.put(Uri.parse("$endPoint/goal/$goalID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": goalName,
            "due_date": dueDate,
            "description": description,
            "rem_owners": ownersToRemove,
            "add_owners": ownersToAdd,
            "color": color
          }));
      final goal = jsonDecode(response.body);
      return goal;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Remove a Goal from your Workspace.
  ///
  /// Goal ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``
  Future<Map<String, dynamic>> deleteGoal({required double goalID}) async {
    try {
      final response = await httpClient.delete(
        Uri.parse("$endPoint/goal/$goalID"),
        headers: {
          "Authorization": authToken,
          "Content-Type": "application/json"
        },
      );
      final goal = jsonDecode(response.body);
      return goal;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Add a Target to a Goal.
  ///
  /// Goal ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``
  ///
  /// Type should be one of the ``["number","currency","boolean","percentage","automatic"]``

  Future<Map<String, dynamic>> createKeyResult({required double goalID, required String goalName, required List<int> owners, required String type, required int stepsStart, required int stepsEnd, required String unit, required List<String> taskIDs, required List<String> listIDs}) async {
    final allowedTypes = [
      "number",
      "currency",
      "boolean",
      "percentage",
      "automatic"
    ];

    if (!allowedTypes.contains(type)) {
      throw ClickUpException(exceptionType: ClickUpExceptionType.invalidModel, exceptionMessage: "Please use one of the available types. Check function documentation for more information");
    }

    try {
      final response = await httpClient.post(Uri.parse("$endPoint/goal/$goalID/key_result"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": goalName,
            "owners": owners,
            "type": type,
            "steps_start": stepsStart,
            "steps_end": stepsEnd,
            "unit": unit,
            "task_ids": taskIDs,
            "list_ids": listIDs
          }));
      final keyResult = jsonDecode(response.body);
      return keyResult;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Update a Target.
  ///
  /// Goal ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``
  ///
  /// Type should be one of the ``["number","currency","boolean","percentage","automatic"]``

  Future<Map<String, dynamic>> editKeyResult({required double keyResultID, required String goalName, required List<int> owners, required String type, required int stepsStart, required int stepsCurrent, required int stepsEnd, required String unit, required String note, required List<String> taskIDs, required List<String> listIDs}) async {
    final allowedTypes = [
      "number",
      "currency",
      "boolean",
      "percentage",
      "automatic"
    ];

    if (!allowedTypes.contains(type)) {
      throw ClickUpException(exceptionType: ClickUpExceptionType.invalidModel, exceptionMessage: "Please use one of the available types. Check function documentation for more information");
    }

    try {
      final response = await httpClient.put(Uri.parse("$endPoint/key_result/$keyResultID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": goalName,
            "owners": owners,
            "type": type,
            "steps_start": stepsStart,
            "steps_end": stepsEnd,
            "unit": unit,
            "task_ids": taskIDs,
            "list_ids": listIDs,
            "steps_current": stepsCurrent,
            "note": note
          }));
      final keyResult = jsonDecode(response.body);
      return keyResult;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Update a Target.
  ///
  /// Goal ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``
  ///
  /// Type should be one of the ``["number","currency","boolean","percentage","automatic"]``

  Future<Map<String, dynamic>> deleteKeyResult({required double keyResultID}) async {
    try {
      final response = await httpClient.delete(
        Uri.parse("$endPoint/key_result/$keyResultID"),
        headers: {
          "Authorization": authToken,
        },
      );
      final keyResult = jsonDecode(response.body);
      return keyResult;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
