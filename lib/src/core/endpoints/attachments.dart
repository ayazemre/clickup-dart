import 'dart:convert';
import 'package:http/http.dart';

class ClickUpAttachments {
  ClickUpAttachments({required this.endPoint, required this.authToken});
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
      final request = MultipartRequest("POST", Uri.parse(useCustomTaskID ? "$endPoint/task/$taskID/attachment?custom_task_ids=true&team_id=$teamID" : "$endPoint/task/$taskID/attachment"))
        ..headers.addAll({
          "Authorization": authToken
        })
        ..files.add(await MultipartFile.fromPath("attachment", filePath));
      final response = await request.send();
      final result = await response.stream.bytesToString();
      return jsonDecode(result);
    } catch (e) {
      print(e);
      return {
        "error": e.toString()
      };
    }
  }
}
