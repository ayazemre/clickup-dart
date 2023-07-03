import 'dart:convert';

import 'package:clickup_dart_sdk/src/core/clickup_exception.dart';
import 'package:http/http.dart';

class ClickUpComments {
  late String endPoint;
  late String authToken;
  late Client httpClient;
  ClickUpComments(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});

  Future<Map<String, dynamic>> getTaskComments({
    required String taskID,
    bool useCustomTaskID = false,
    int? teamID,
    int? start,
    String? startID,
  }) async {
    try {
      final response = await httpClient.get(
          Uri.parse(useCustomTaskID
              ? "$endPoint/task/$taskID/comment?custom_task_ids=true&team_id=$teamID"
              : "$endPoint/task/$taskID/comment"),
          headers: {"Authorization": authToken});
      final comments = jsonDecode(response.body);
      return comments;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Creates a comment on specific task in your space. Map model for the comment parameter is;
  ///
  /// ```
  /// {
  /// "comment_text": "This is my sample comment",  // Should be String.
  /// "assignee": 123456,   // Should be an int.
  /// "notify_all": false   // Should be a boolean.
  /// }
  /// ```

  Future<Map<String, dynamic>> createTaskComment({
    required String taskID,
    required Map<String, dynamic> comment,
    bool useCustomTaskID = false,
    int? teamID,
  }) async {
    if (!comment.containsKey("comment_text") &&
        !comment.containsKey("assignee") &&
        !comment.containsKey("notify_all")) {
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.invalidModel,
          exceptionMessage:
              "Your data does not match API's model requirements. Please check documentation.");
    }
    try {
      final response = await httpClient.post(
          Uri.parse(useCustomTaskID
              ? "$endPoint/task/$taskID/comment?custom_task_ids=true&team_id=$teamID"
              : "$endPoint/task/$taskID/comment"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(comment));
      final createdComment = jsonDecode(response.body);
      return createdComment;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> getChatViewComments({
    required String viewID,
    int? start,
    String? startID,
  }) async {
    try {
      final response = await httpClient.get(
          Uri.parse(start != null && startID != null
              ? "$endPoint/view/$viewID/comment?start=$start&start_id=$startID"
              : "$endPoint/view/$viewID/comment"),
          headers: {
            "Authorization": authToken,
          });
      final createdComment = jsonDecode(response.body);
      return createdComment;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> createChatViewComment({
    required String viewID,
    required Map<String, dynamic> comment,
  }) async {
    if (!comment.containsKey("comment_text") &&
        !comment.containsKey("notify_all")) {
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.invalidModel,
          exceptionMessage:
              "Your data does not match API's model requirements. Please check documentation.");
    }
    try {
      final response = await httpClient.post(
          Uri.parse("$endPoint/view/$viewID/comment"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(comment));
      final createdComment = jsonDecode(response.body);
      return createdComment;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> getListComments({
    required double listID,
    int? start,
    String? startID,
  }) async {
    try {
      final response = await httpClient.get(
          Uri.parse(start != null && startID != null
              ? "$endPoint/list/$listID/comment?start=$start&start_id=$startID"
              : "$endPoint/list/$listID/comment"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          });
      final createdComment = jsonDecode(response.body);
      return createdComment;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> createListComment({
    required String listID,
    required Map<String, dynamic> comment,
  }) async {
    if (!comment.containsKey("comment_text") &&
        !comment.containsKey("assignee") &&
        !comment.containsKey("notify_all")) {
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.invalidModel,
          exceptionMessage:
              "Your data does not match API's model requirements. Please check documentation.");
    }

    try {
      final response = await httpClient.post(
          Uri.parse("$endPoint/list/$listID/comment"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(comment));
      final createdComment = jsonDecode(response.body);
      return createdComment;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> updateComment({
    required double commentID,
    required Map<String, dynamic> comment,
  }) async {
    if (!comment.containsKey("comment_text") &&
        !comment.containsKey("assignee") &&
        !comment.containsKey("resolved")) {
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.invalidModel,
          exceptionMessage:
              "Your data does not match API's model requirements. Please check documentation.");
    }
    try {
      final response = await httpClient.put(
          Uri.parse("$endPoint/comment/$commentID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(comment));
      final createdComment = jsonDecode(response.body);
      return createdComment;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> deleteComment({
    required double commentID,
  }) async {
    try {
      final response = await httpClient
          .delete(Uri.parse("$endPoint/comment/$commentID"), headers: {
        "Authorization": authToken,
        "Content-Type": "application/json"
      });
      final createdComment = jsonDecode(response.body);
      return createdComment;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
