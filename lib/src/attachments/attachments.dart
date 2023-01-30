import 'package:http/http.dart';

class ClickUpAttachments {
  ClickUpAttachments({required this.endPoint, required this.apiToken});
  final String endPoint;
  final String apiToken;

  Future<void> createTaskAttachment(
    String taskID,
    Map<String, dynamic> queryParams,
  ) async {
    final reponse = await post(
        Uri.parse(endPoint + "/task/$taskID/attachment?$queryParams"),
        headers: {
          "Authorization": "$apiToken",
          "Content-Type": "multipart/form-data"
        });
  }
}
