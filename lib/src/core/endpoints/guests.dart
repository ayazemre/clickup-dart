import 'dart:convert';

import 'package:http/http.dart';

import '../clickup_exception.dart';

class ClickUpGuests {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpGuests({required this.endPoint, required this.authToken, required this.httpClient});

  /// Invite a guest to join a Workspace. To invite a member to your Workspace, use the Invite User to Workspace endpoint.
  ///
  /// You'll also need to grant the guest access to specific items using the following endpoints: Add Guest to Folder, Add Guest to List, or Add Guest to Task.
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> inviteGuestToWorkspace({required double teamID, required String email, required bool canEditTags, required bool canSeeTimeSpent, required bool canSeeTimeEstimated, required bool canCreateViews, required int customRoleID}) async {
    try {
      final response = await httpClient.post(Uri.parse("$endPoint/team/$teamID/guest"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "email": email,
            "can_edit_tags": canEditTags,
            "can_see_time_spent": canSeeTimeSpent,
            "can_see_time_estimated": canSeeTimeEstimated,
            "can_create_views": canCreateViews,
            "custom_role_id": customRoleID
          }));
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// View information about a guest.
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> getGuest({required double teamID, required double guestID}) async {
    try {
      final response = await httpClient.get(Uri.parse("$endPoint/team/$teamID/guest/$guestID"), headers: {
        "Authorization": authToken,
      });
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Rename and configure options for a guest.
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> editGuestOnWorkspace({required double teamID, required double guestID, required String username, required bool canEditTags, required bool canSeeTimeSpent, required bool canSeeTimeEstimated, required bool canCreateViews, required int customRoleID}) async {
    try {
      final response = await httpClient.put(Uri.parse("$endPoint/team/$teamID/guest/$guestID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "username": username,
            "can_edit_tags": canEditTags,
            "can_see_time_spent": canSeeTimeSpent,
            "can_see_time_estimated": canSeeTimeEstimated,
            "can_create_views": canCreateViews,
            "custom_role_id": customRoleID
          }));
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Revoke a guest's access to a Workspace.
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> removeGuestFromWorkspace({required double teamID, required double guestID}) async {
    try {
      final response = await httpClient.delete(Uri.parse("$endPoint/team/$teamID/guest/$guestID"), headers: {
        "Authorization": authToken,
      });
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Share a task with a guest.
  ///
  /// Allowed permissions are ``["read", "comment", "edit", "create"]``
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> addGuestToTask({required String taskID, required double guestID, required String permissionLevel, bool includeShared = true, bool useCustomTaskID = false, double teamID = 0}) async {
    final allowedPermissions = [
      "read",
      "comment",
      "edit",
      "create"
    ];

    if (!allowedPermissions.contains(permissionLevel)) {
      throw ClickUpException(exceptionType: ClickUpExceptionType.invalidModel, exceptionMessage: "You need to select one of the allowed permissions for the guest user.");
    }
    try {
      final response = await httpClient.post(Uri.parse(useCustomTaskID ? "$endPoint/task/$taskID/guest/$guestID?include_shared=$includeShared&custom_task_ids=true&team_id=$teamID" : "$endPoint/task/$taskID/guest/$guestID?include_shared=$includeShared"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "permission_level": permissionLevel
          }));
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Revoke a guest's access to a task.
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> removeGuestFromTask({required String taskID, required double guestID, bool includeShared = true, bool useCustomTaskID = false, double teamID = 0}) async {
    try {
      final response = await httpClient.delete(Uri.parse(useCustomTaskID ? "$endPoint/task/$taskID/guest/$guestID?include_shared=$includeShared&custom_task_ids=true&team_id=$teamID" : "$endPoint/task/$taskID/guest/$guestID?include_shared=$includeShared"), headers: {
        "Authorization": authToken
      });
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Share a List with a guest.
  ///
  /// Allowed permissions are ``["read", "comment", "edit", "create"]``
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> addGuestToList({required double listID, required double guestID, required String permissionLevel, bool includeShared = true}) async {
    final allowedPermissions = [
      "read",
      "comment",
      "edit",
      "create"
    ];

    if (!allowedPermissions.contains(permissionLevel)) {
      throw ClickUpException(exceptionType: ClickUpExceptionType.invalidModel, exceptionMessage: "You need to select one of the allowed permissions for the guest user.");
    }
    try {
      final response = await httpClient.post(Uri.parse("$endPoint/list/$listID/guest/$guestID?include_shared=$includeShared"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "permission_level": permissionLevel
          }));
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Revoke a guest's access to a List.
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> removeGuestFromList({required double listID, required double guestID, bool includeShared = true}) async {
    try {
      final response = await httpClient.delete(Uri.parse("$endPoint/list/$listID/guest/$guestID?include_shared=$includeShared"), headers: {
        "Authorization": authToken
      });
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Share a Folder with a guest.
  ///
  /// Allowed permissions are ``["read", "comment", "edit", "create"]``
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> addGuestToFolder({required double folderID, required double guestID, required String permissionLevel, bool includeShared = true}) async {
    final allowedPermissions = [
      "read",
      "comment",
      "edit",
      "create"
    ];

    if (!allowedPermissions.contains(permissionLevel)) {
      throw ClickUpException(exceptionType: ClickUpExceptionType.invalidModel, exceptionMessage: "You need to select one of the allowed permissions for the guest user.");
    }
    try {
      final response = await httpClient.post(Uri.parse("$endPoint/folder/$folderID/guest/$guestID?include_shared=$includeShared"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "permission_level": permissionLevel
          }));
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Revoke a guest's access to a Folder.
  ///
  /// Note: This endpoint is only available to Workspaces on our Enterprise Plan.

  Future<Map<String, dynamic>> removeGuestFromFolder({required double folderID, required double guestID, bool includeShared = true}) async {
    try {
      final response = await httpClient.delete(Uri.parse("$endPoint/folder/$folderID/guest/$guestID?include_shared=$includeShared"), headers: {
        "Authorization": authToken
      });
      final guest = jsonDecode(response.body);
      return guest;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(exceptionType: ClickUpExceptionType.requestError, exceptionMessage: "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
