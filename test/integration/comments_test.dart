import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:clickup_dart_sdk/src/core/clickup_exception.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('Comments Tests', () {
    setUp(() async {
      // Setting up the SDK with a random token and mock server. ClickUp's official mock server accepts random tokens as valid tokens.
      token = "pk_qwerty123456";
      clickUp = ClickUp(
          apiEndpoint:
              "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")
        ..initialize(authToken: token);
    });

    test('Comments - Get Task Comments', () async {
      final taskComments =
          await clickUp.comments.getTaskComments(taskID: "a1b2c3");
      expect(taskComments.containsKey("comments"), true);
    });
    test('Comments - Create Task Comment', () async {
      final createdComment = await clickUp.comments.createTaskComment(
          taskID: "a1b2c3",
          comment: {
            "comment_text": "Hi I am Emre",
            "assignee": 123456,
            "notify_all": true
          });
      expect(createdComment.containsKey("id"), true);
    });
    test('Comments - Create Task Comment - Invalid Data', () async {
      expect(
          () async => await clickUp.comments
              .createTaskComment(taskID: "a1b2c3", comment: {}),
          throwsA(isA<ClickUpException>()));
    });

    test('Comments - Get Chat View Comments - Last 25', () async {
      final chatViewComments =
          await clickUp.comments.getChatViewComments(viewID: "12345");

      expect(chatViewComments.containsKey("comments"), true);
    });
    test('Comments - Get Chat View Comments - Custom Range', () async {
      final chatViewComments = await clickUp.comments
          .getChatViewComments(viewID: "12345", start: 3, startID: "12345");

      expect(chatViewComments.containsKey("comments"), true);
    });
    test('Comments - Create Chat View Comment', () async {
      final createdChatViewComment = await clickUp.comments
          .createChatViewComment(
              viewID: "12345",
              comment: {"comment_text": "Hi I am Emre", "notify_all": true});

      expect(createdChatViewComment.containsKey("id"), true);
    });
    test('Comments - Create Chat View Comment - Invalid Data', () async {
      expect(
          () async => await clickUp.comments
              .createChatViewComment(viewID: "12345", comment: {}),
          throwsA(isA<ClickUpException>()));
    });
    test('Comments - Get List Comments - Last 25', () async {
      final listComments =
          await clickUp.comments.getListComments(listID: 12345);

      expect(listComments.containsKey("comments"), true);
    });
    test('Comments - Get List Comments - Custom Range', () async {
      final listComments = await clickUp.comments
          .getListComments(listID: 12345, start: 2, startID: "123");

      expect(listComments.containsKey("comments"), true);
    });

    test('Comments - Create List Comment', () async {
      final listComment = await clickUp.comments.createListComment(
          listID: "12345",
          comment: {
            "comment_text": "Hi I am Emre",
            "assignee": 123456,
            "notify_all": true
          });
      expect(listComment.containsKey("id"), true);
    });
    test('Comments - Create List Comment - Invalid Data', () async {
      expect(
          () async => await clickUp.comments
              .createListComment(listID: "12345", comment: {}),
          throwsA(isA<ClickUpException>()));
    });
    test('Comments - Update Comment', () async {
      final updatedComment = await clickUp.comments.updateComment(
          commentID: 1234,
          comment: {
            "comment_text": "Hi I am Emre",
            "assignee": 123456,
            "resolved": true
          });
      expect(updatedComment.isEmpty, true);
    });
    test('Comments - Update Comment - Invalid Data', () async {
      expect(
          () async => await clickUp.comments
              .updateComment(commentID: 1234, comment: {}),
          throwsA(isA<ClickUpException>()));
    });
    test('Comments - Delete Comment', () async {
      final deletedComment =
          await clickUp.comments.deleteComment(commentID: 1234);
      expect(deletedComment.isEmpty, true);
    });
  });
}
