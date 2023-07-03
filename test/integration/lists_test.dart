import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('API endpoint Tests', () {
    setUp(() async {
      // Additional setup goes here.
      token = "pk_qwerty123456";
      clickUp = ClickUp(apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")..initialize(authToken: token);
    });

    test('Lists - Get Lists', () async {
      final lists = await clickUp.lists.getLists(folderID: 1, archived: false);
      print(lists);
      expect(lists.containsKey("lists"), true);
    });

    test('Lists - Create List', () async {
      final lists = await clickUp.lists.createList(folderID: 1, listName: "test list");
      print(lists);
      expect(lists.containsKey("id"), true);
    });
    test('Lists - Create List with params', () async {
      final lists = await clickUp.lists.createList(folderID: 1, listName: "test list", assignee: 1, content: "test");
      print(lists);
      expect(lists.containsKey("id"), true);
    });
  });
}
