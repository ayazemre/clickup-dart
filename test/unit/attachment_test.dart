import 'dart:convert';
import 'package:path/path.dart' as p;

import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;

  group('Attachment Test', () {
    setUp(() async {
      // Setting up the SDK with a random token and mock server. ClickUp's official mock server accepts random tokens as valid tokens.
      token = "pk_qwerty123456";
      clickUp = ClickUp(apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")..initialize(authToken: token);
    });

    test('Upload an attachment', () async {
      final response = await clickUp.attachments.createTaskAttachment(filePath: p.join(p.current, "test", "beksinski_sample.jpg"), taskID: "213123", useCustomTaskID: false);
      expect(response, {
        'message': 'Mock server error. Media type multipart/form-data deserialization is not supported.'
      });
    });
  });
}
