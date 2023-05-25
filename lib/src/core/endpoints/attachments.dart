import 'dart:convert';
import 'package:http/http.dart';

import '../clickup_exception.dart';

class ClickUpAttachments {
  ClickUpAttachments(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});
  final String endPoint;
  final String authToken;
  late Client httpClient;

  Future<Map<String, dynamic>> createTaskAttachment({
    required String taskID,
    required String filePath,
    bool useCustomTaskID = false,
    int? teamID,
  }) async {
    try {
      final request = MultipartRequest(
          "POST",
          Uri.parse(useCustomTaskID
              ? "$endPoint/task/$taskID/attachment?custom_task_ids=true&team_id=$teamID"
              : "$endPoint/task/$taskID/attachment"))
        ..headers.addAll({"Authorization": authToken})
        ..files.add(await MultipartFile.fromPath("attachment", filePath));
      final response = await request.send();
      final result = await response.stream.bytesToString();
      return jsonDecode(result);
    } catch (e) {
      print(e);
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
