import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('Folders Tests', () {
    setUp(() async {
      // Additional setup goes here.
      token = "pk_qwerty123456";
      clickUp = ClickUp(
          apiEndpoint:
              "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")
        ..initialize(authToken: token);
    });

    test('Folders - Get Folders', () async {
      final folders = await clickUp.folders.getFolders(spaceID: 123);
      expect(folders.containsKey("folders"), true);
    });
    test('Folders - Get Folders: Include Archived', () async {
      final folders =
          await clickUp.folders.getFolders(spaceID: 123, includeArchived: true);
      expect(folders.containsKey("folders"), true);
    });
    test('Folders - Create Folder', () async {
      final folder =
          await clickUp.folders.createFolder(spaceID: 123, name: "Test Folder");
      expect(folder.containsKey("name") && folder.containsValue("Test Folder"),
          true);
    });
    test('Folders - Get Folder', () async {
      final folder = await clickUp.folders.getFolder(folderID: 123);
      expect(folder.containsKey("id"), true);
    });
    test('Folders - Update Folder', () async {
      final folder = await clickUp.folders
          .updateFolder(folderID: 123, name: "Test Updated Folder");
      expect(
          folder.containsKey("name") &&
              folder.containsValue("Test Updated Folder") &&
              folder.containsKey("id"),
          true);
    });
    test('Folders - Delete Folder', () async {
      final folder = await clickUp.folders.deleteFolder(folderID: 123);
      expect(folder.isEmpty, true);
    });
  });
}
