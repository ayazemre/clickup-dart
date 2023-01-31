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

  void initialize({required String authToken}) async {
    auth = ClickUpAuth(endPoint: apiEndpoint, authToken: authToken);
    attachments =
        ClickUpAttachments(endPoint: apiEndpoint, authToken: auth.authToken);
    checklists =
        ClickUpChecklists(endPoint: apiEndpoint, authToken: auth.authToken);
    comments =
        ClickUpComments(endPoint: apiEndpoint, authToken: auth.authToken);
    customFields =
        ClickUpCustomFields(endPoint: apiEndpoint, authToken: auth.authToken);
    dependencies =
        ClickUpDependencies(endPoint: apiEndpoint, authToken: auth.authToken);
    folders = ClickUpFolders(endPoint: apiEndpoint, authToken: auth.authToken);
    goals = ClickUpGoals(endPoint: apiEndpoint, authToken: auth.authToken);
    guests = ClickUpGuests(endPoint: apiEndpoint, authToken: auth.authToken);
    lists = ClickUpLists(endPoint: apiEndpoint, authToken: auth.authToken);
    members = ClickUpMembers(endPoint: apiEndpoint, authToken: auth.authToken);
    roles = ClickUpRoles(endPoint: apiEndpoint, authToken: auth.authToken);
    sharedHierarchy = ClickUpSharedHierarchy(
        endPoint: apiEndpoint, authToken: auth.authToken);
    spaces = ClickUpSpaces(endPoint: apiEndpoint, authToken: auth.authToken);
    tags = ClickUpTags(endPoint: apiEndpoint, authToken: auth.authToken);
    tasks = ClickUpTasks(endPoint: apiEndpoint, authToken: auth.authToken);
    taskTemplates =
        ClickUpTaskTemplates(endPoint: apiEndpoint, authToken: auth.authToken);
    teams = ClickUpTeams(endPoint: apiEndpoint, authToken: auth.authToken);
    timeTrackingLegacy = ClickUpTimeTrackingLegacy(
        endPoint: apiEndpoint, authToken: auth.authToken);
    timeTrackingV2 =
        ClickUpTimeTrackingV2(endPoint: apiEndpoint, authToken: auth.authToken);
    users = ClickUpUsers(endPoint: apiEndpoint, authToken: auth.authToken);
    views = ClickUpViews(endPoint: apiEndpoint, authToken: auth.authToken);
    webhooks =
        ClickUpWebhooks(endPoint: apiEndpoint, authToken: auth.authToken);
    print("ClickUp Initialized..");
  }
}
