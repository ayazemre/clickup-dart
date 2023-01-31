import 'dart:convert';
import 'dart:io';

import 'package:clickup_dart/clickup_dart.dart';

void main() async {
  final token = "pk_testrandomtoken123";
  // Initialize with mock server for testing
  final clickUp = ClickUp(
      apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")
    ..initialize(authToken: token);

  final attachment = await clickUp.attachments.createTaskAttachment(
      taskID: "8669e046h",
      useCustomTaskID: false,
      filePath: "./test/beksinski_sample.jpg");

  print(attachment);
}
