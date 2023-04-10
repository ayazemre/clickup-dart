import 'dart:convert';

import 'package:http/http.dart';

class ClickUpComments {
  late String endPoint;
  late String authToken;
  ClickUpComments({required this.endPoint, required this.authToken});

  Future<Map<String, dynamic>> getTaskComments({
    required String taskID,
    bool useCustomTaskID = false,
    int? teamID,
    int? start,
    String? startID,
  }) async {
    try {
      final response = await get(Uri.parse("$endPoint/task/$taskID/comment"),
          headers: {"Authorization": authToken});
      final comments = jsonDecode(response.body);
      return comments;
    } catch (e) {
      print(e.toString());
      return {"error": "$e"};
    }
  }
}
