import 'package:clickup_dart/src/attachments/attachments.dart';
import 'package:clickup_dart/src/auth/auth.dart';
import 'package:clickup_dart/src/checklists/checklists.dart';
import 'package:clickup_dart/src/comments/comments.dart';
import 'package:clickup_dart/src/custom_fields/custom_fields.dart';
import 'package:clickup_dart/src/dependencies/dependencies.dart';
import 'package:clickup_dart/src/folders/folders.dart';
import 'package:clickup_dart/src/goals/goals.dart';
import 'package:clickup_dart/src/guests/guests.dart';
import 'package:clickup_dart/src/lists/lists.dart';
import 'package:clickup_dart/src/members/members.dart';
import 'package:clickup_dart/src/roles/roles.dart';
import 'package:clickup_dart/src/shared_hierarchy/shared_hierarchy.dart';
import 'package:clickup_dart/src/spaces/spaces.dart';
import 'package:clickup_dart/src/tags/tags.dart';
import 'package:clickup_dart/src/tasks/task_templates.dart';
import 'package:clickup_dart/src/tasks/tasks.dart';
import 'package:clickup_dart/src/teams/teams.dart';
import 'package:clickup_dart/src/time_tracking/time_tracking_legacy.dart';
import 'package:clickup_dart/src/time_tracking/time_tracking_v2.dart';
import 'package:clickup_dart/src/users/users.dart';
import 'package:clickup_dart/src/views/views.dart';
import 'package:clickup_dart/src/webhooks/webhooks.dart';

class ClickUp {
  late final String apiEndpoint;

  late final ClickUpAuth auth;
  late final ClickUpAttachments attachments;
  late final ClickUpChecklists checklists;
  late final ClickUpComments comments;
  late final ClickUpCustomFields customFields;
  late final ClickUpDependencies dependencies;
  late final ClickUpFolders folders;
  late final ClickUpGoals goals;
  late final ClickUpGuests guests;
  late final ClickUpLists lists;
  late final ClickUpMembers members;
  late final ClickUpRoles roles;
  late final ClickUpSharedHierarchy sharedHierarchy;
  late final ClickUpSpaces spaces;
  late final ClickUpTags tags;
  late final ClickUpTasks tasks;
  late final ClickUpTaskTemplates taskTemplates;
  late final ClickUpTeams teams;
  late final ClickUpTimeTrackingLegacy timeTrackingLegacy;
  late final ClickUpTimeTrackingV2 timeTrackingV2;
  late final ClickUpUsers users;
  late final ClickUpViews views;
  late final ClickUpWebhooks webhooks;

  ClickUp({
    this.apiEndpoint = "https://api.clickup.com/api/v2",
  });
  void initialize(
      {String apiEndpoint = "https://api.clickup.com/api/v2",
      String? authToken}) async {}

  void _initObject(Map schema) {
    print("----------------");
    switch (schema.entries.first.value) {
      case "Attachments":
        print(schema);
        break;
      case "Authorization":
        auth = ClickUpAuth();
        break;
      case "Checklists":
        print(schema.entries.first.value);
        break;
      case "Comments":
        print(schema.entries.first.value);
        break;
      case "Custom Fields":
        print(schema.entries.first.value);
        break;
      case "Dependencies":
        print(schema.entries.first.value);
        break;
      case "Folders":
        print(schema.entries.first.value);
        break;
      case "Goals":
        print(schema.entries.first.value);
        break;
      case "Guests":
        print(schema.entries.first.value);
        break;
      case "Lists":
        print(schema.entries.first.value);
        break;
      case "Members":
        print(schema.entries.first.value);
        break;
      case "Roles":
        print(schema.entries.first.value);
        break;
      case "Shared Hierarchy":
        print(schema.entries.first.value);
        break;
      case "Spaces":
        print(schema.entries.first.value);
        break;
      case "Tags":
        print(schema.entries.first.value);
        break;
      case "Tasks":
        print(schema.entries.first.value);
        break;
      case "Task Templates":
        print(schema.entries.first.value);
        break;
      case "Teams (User Groups)":
        print(schema.entries.first.value);
        break;
      case "Teams (Workspaces)":
        print(schema.entries.first.value);
        break;
      case "Time Tracking Legacy":
        print(schema.entries.first.value);
        break;
      case "Time Tracking 2.0":
        print(schema.entries.first.value);
        break;
      case "Users":
        print(schema.entries.first.value);
        break;
      case "Views":
        print(schema.entries.first.value);
        break;
      case "Webhooks":
        print(schema.entries.first.value);
        break;
      default:
        print("switch case failed");
    }
  }
}
