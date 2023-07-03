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

    test('Guests - Invite Guest To Workspace', () async {
      final guest = await clickUp.guests.inviteGuestToWorkspace(teamID: 1, email: "guest@example.com", canSeeTimeSpent: false, canCreateViews: false, canEditTags: false, canSeeTimeEstimated: true, customRoleID: 12345);
      print(guest);
      expect(guest.containsKey("team"), true);
    });

    test('Guests - Get Guest', () async {
      final guest = await clickUp.guests.getGuest(teamID: 1, guestID: 2);
      print(guest);
      expect(guest.isEmpty, true);
    });
    test('Guests - Edit Guest On Workspace', () async {
      final guest = await clickUp.guests.editGuestOnWorkspace(teamID: 1, guestID: 2, username: "guest@example.com", canSeeTimeSpent: false, canCreateViews: false, canEditTags: false, canSeeTimeEstimated: true, customRoleID: 12345);
      print(guest);
      expect(guest.containsKey("guest"), true);
    });

    test('Guests - Remove Guest From Workspace', () async {
      final guest = await clickUp.guests.removeGuestFromWorkspace(teamID: 1, guestID: 2);
      print(guest);
      expect(guest.containsKey("team"), true);
    });
    test('Guests - Add Guest To Task', () async {
      final guest = await clickUp.guests.addGuestToTask(taskID: "1234", guestID: 2456, permissionLevel: "read");
      print(guest);
      expect(guest.containsKey("guest"), true);
    });
    test('Guests - Add Guest To Task with Custom Task Id', () async {
      final guest = await clickUp.guests.addGuestToTask(taskID: "1", guestID: 2, permissionLevel: "edit", includeShared: false, useCustomTaskID: true);
      print(guest);
      expect(guest.containsKey("guest"), true);
    });
    test('Guests - Remove Guest From Task', () async {
      final guest = await clickUp.guests.removeGuestFromTask(taskID: "1", guestID: 2, includeShared: false, useCustomTaskID: true);
      print(guest);
      expect(guest.containsKey("guest"), true);
    });

    test('Guests - Add Guest To List', () async {
      final guest = await clickUp.guests.addGuestToList(listID: 1, guestID: 2, includeShared: false, permissionLevel: "read");
      print(guest);
      expect(guest.containsKey("guest"), true);
    });

    test('Guests - Remove Guest From List', () async {
      final guest = await clickUp.guests.removeGuestFromList(listID: 1, guestID: 2, includeShared: false);
      print(guest);
      expect(guest.containsKey("guest"), true);
    });

    test('Guests - Add Guest To Folder', () async {
      final guest = await clickUp.guests.addGuestToFolder(folderID: 1, guestID: 2, includeShared: false, permissionLevel: "read");
      print(guest);
      expect(guest.containsKey("guest"), true);
    });
    test('Guests - Remove Guest From Folder', () async {
      final guest = await clickUp.guests.removeGuestFromFolder(folderID: 1, guestID: 2, includeShared: false);
      print(guest);
      expect(guest.containsKey("guest"), true);
    });
  });
}
