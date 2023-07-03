import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('Task Checklists endpoint Tests', () {
    setUp(() async {
      // Additional setup goes here.
      token = "pk_qwerty123456";
      clickUp = ClickUp(apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")..initialize(authToken: token);
    });

    test('Task Checklists - Create a checklist', () async {
      final checklist = await clickUp.taskChecklists.createChecklist(checklistName: "Test", taskID: "asdf123asde");
      print(checklist);
      expect(checklist.containsKey("checklist"), true);
    });

    test('Task Checklists - Edit a checklist', () async {
      final checklist = await clickUp.taskChecklists.editChecklist(checklistID: "b8a8-48d8-a0c6-b4200788a683", checklistName: "New Name", position: 0);
      print(checklist);
      expect(checklist.isEmpty, true);
    });

    test('Task Checklists - Delete a checklist', () async {
      final checklist = await clickUp.taskChecklists.deleteChecklist(checklistID: "b8a8-48d8-a0c6-b4200788a683");
      print(checklist);
      expect(checklist.isEmpty, true);
    });
    test('Task Checklists - Create a checklist item', () async {
      final checklist = await clickUp.taskChecklists.createChecklistItem(checklistName: "New Name", assignee: 123, checklistID: "b8a8-48d8-a0c6-b4200788a683");
      print(checklist);
      expect(checklist.containsKey("checklist"), true);
    });

    test('Task Checklists - Edit a checklist item', () async {
      final checklist = await clickUp.taskChecklists.editChecklistItem(checklistName: "New Name", assignee: "123", resolved: false, parent: "test", checklistItemID: "b8a8-48d8-a0c6-b4200788a683", checklistID: "b8a8-48d8-a0c6-b4200788a683");
      print(checklist);
      expect(checklist.containsKey("checklist"), true);
    });
    test('Task Checklists - Edit a checklist item', () async {
      final checklist = await clickUp.taskChecklists.deleteChecklistItem(checklistItemID: "b8a8-48d8-a0c6-b4200788a683", checklistID: "b8a8-48d8-a0c6-b4200788a683");
      print(checklist);
      expect(checklist.isEmpty, true);
    });
  });
}
