import 'dart:convert';

import 'package:http/http.dart';

import '../clickup_exception.dart';

class ClickUpTaskChecklists {
  late String endPoint;
  late String authToken;
  late Client httpClient;
  ClickUpTaskChecklists({required this.endPoint, required this.authToken, required this.httpClient});

  /// Adds a new checklist on a specific task in your space.

  Future<Map<String, dynamic>> createChecklist({required String checklistName, required String taskID, bool useCustomTaskID = false, double teamID = 0}) async {
    try {
      final response = await httpClient.post(Uri.parse(useCustomTaskID ? "$endPoint/task/$taskID/checklist?custom_task_ids=true&team_id=$teamID" : "$endPoint/task/$taskID/checklist"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": checklistName
          }));
      final checklist = jsonDecode(response.body);
      return checklist;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Rename a task checklist, or reorder a checklist so it appears above or below other checklists on a task.
  ///
  /// Checklist ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``
  ///
  /// Position refers to the order of appearance of checklists on a task. To set a checklist to appear at the top of the checklists section of a task, use ``"position": 0``.

  Future<Map<String, dynamic>> editChecklist({required String checklistName, required int position, required String checklistID}) async {
    try {
      final response = await httpClient.put(Uri.parse("$endPoint/checklist/$checklistID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": checklistName,
            "position": position
          }));
      final checklist = jsonDecode(response.body);
      return checklist;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Delete a checklist from a task.
  ///
  /// Checklist ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``

  Future<Map<String, dynamic>> deleteChecklist({required String checklistID}) async {
    try {
      final response = await httpClient.delete(Uri.parse("$endPoint/checklist/$checklistID"), headers: {
        "Authorization": authToken,
      });
      final checklist = jsonDecode(response.body);
      return checklist;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Add a line item to a task checklist.
  ///
  /// Checklist ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``

  Future<Map<String, dynamic>> createChecklistItem({required String checklistName, required int assignee, required String checklistID}) async {
    try {
      final response = await httpClient.post(Uri.parse("$endPoint/checklist/$checklistID/checklist_item"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": checklistName,
            "assignee": assignee
          }));
      final checklist = jsonDecode(response.body);
      return checklist;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Update an individual line item in a task checklist. You can rename it, set the assignee, mark it as resolved, or nest it under another checklist item.
  ///
  /// Checklist ID and Checklist Item ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``
  ///
  /// To nest a checklist item under another checklist item, include the other item's ``checklistItemId``.

  Future<Map<String, dynamic>> editChecklistItem({required String checklistName, String assignee = "null", required bool resolved, String parent = "null", required String checklistID, required String checklistItemID}) async {
    try {
      final response = await httpClient.put(Uri.parse("$endPoint/checklist/$checklistID/checklist_item/$checklistItemID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": checklistName,
            "assignee": assignee,
            "resolved": resolved,
            "parent": parent
          }));
      final checklist = jsonDecode(response.body);
      return checklist;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Delete a line item from a task checklist.
  ///
  /// Checklist ID and Checklist Item ID should be a valid UUID ``(b8a8-48d8-a0c6-b4200788a683)``

  Future<Map<String, dynamic>> deleteChecklistItem({required String checklistID, required String checklistItemID}) async {
    try {
      final response = await httpClient.delete(Uri.parse("$endPoint/checklist/$checklistID/checklist_item/$checklistItemID"), headers: {
        "Authorization": authToken,
      });
      final checklist = jsonDecode(response.body);
      return checklist;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
