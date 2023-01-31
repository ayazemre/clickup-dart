import 'dart:convert';
import 'dart:io';
import 'package:clickup_dart/clickup_dart.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('API endpoint Tests', () {
    setUp(() async {
      // Additional setup goes here.
      token = "pk_qwerty123456";
      clickUp = ClickUp(
          apiEndpoint:
              "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")
        ..initialize(authToken: token);
    });

    /// TO-DO: Oauth Testing
    ///
    test('Authorization - Get Authorized User', () async {
      final user = await clickUp.auth.getAuthorizedUser();
      print(user);
      expect(user.containsKey("user"), true);
    });
    test('Authorization - Get Authorized Teams', () async {
      final teams = await clickUp.auth.getAuthorizedTeams();
      print(teams);
      expect(teams.containsKey("teams"), true);
    });
    test('Attachments - Create Task Attachment', () async {
      final attachment = await clickUp.attachments.createTaskAttachment(
          taskID: "8669e046h",
          useCustomTaskID: false,
          filePath: "./test/beksinski_sample.jpg");
      print(attachment);
      expect(attachment.containsKey("message"), true);
    });
  });
}
