import 'dart:convert';

import 'package:http/http.dart';

import '../clickup_exception.dart';

class ClickUpLists {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpLists({required this.endPoint, required this.authToken, required this.httpClient});

  /// View the Lists within a Folder.

  Future<Map<String, dynamic>> getLists({required double folderID, bool archived = false}) async {
    try {
      final response = await httpClient.get(Uri.parse("$endPoint/folder/$folderID/list?archived=$archived"), headers: {
        "Authorization": authToken,
      });
      final goals = jsonDecode(response.body);
      return goals;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Add a new List to a Folder.
  ///
  /// Include a ``assignee`` to assign this List.
  ///
  /// Status refers to the List color rather than the task Statuses available in the List.

  Future<Map<String, dynamic>> createList({required double folderID, required String listName, String? content, int? dueDate, bool? dueDateTime, int? priority, int? assignee, String? status}) async {
    Map<String, dynamic> body = {
      "name": listName
    };

    content != null
        ? body.addAll({
            "content": content
          })
        : () => {};
    dueDate != null
        ? body.addAll({
            "due_date": dueDate
          })
        : () => {};
    dueDateTime != null
        ? body.addAll({
            "due_date_time": dueDateTime
          })
        : () => {};
    priority != null
        ? body.addAll({
            "priority": priority
          })
        : () => {};
    assignee != null
        ? body.addAll({
            "assignee": assignee
          })
        : () => {};
    status != null
        ? body.addAll({
            "status": status
          })
        : () => {};

    try {
      final response = await httpClient.post(Uri.parse("$endPoint/folder/$folderID/list"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(body));
      final goals = jsonDecode(response.body);
      return goals;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
