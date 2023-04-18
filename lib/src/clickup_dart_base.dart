import 'package:http/http.dart';

import 'core/endpoints/attachments.dart';
import 'core/endpoints/auth.dart';
import 'core/endpoints/task_checklists.dart';
import 'core/endpoints/comments.dart';
import 'core/endpoints/custom_fields.dart';
import 'core/endpoints/dependencies.dart';
import 'core/endpoints/folders.dart';
import 'core/endpoints/goals.dart';
import 'core/endpoints/guests.dart';
import 'core/endpoints/lists.dart';
import 'core/endpoints/members.dart';
import 'core/endpoints/roles.dart';
import 'core/endpoints/shared_hierarchy.dart';
import 'core/endpoints/spaces.dart';
import 'core/endpoints/tags.dart';
import 'core/endpoints/task_templates.dart';
import 'core/endpoints/tasks.dart';
import 'core/endpoints/teams.dart';
import 'core/endpoints/time_tracking_legacy.dart';
import 'core/endpoints/time_tracking_v2.dart';
import 'core/endpoints/users.dart';
import 'core/endpoints/views.dart';
import 'core/endpoints/webhooks.dart';

class ClickUp {
  late final String apiEndpoint;
  late final Client httpClient;

  late final ClickUpAuth auth;
  late final ClickUpAttachments attachments;
  late final ClickUpTaskChecklists taskChecklists;
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
    httpClient = Client();

    auth = ClickUpAuth(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    attachments = ClickUpAttachments(endPoint: apiEndpoint, authToken: auth.authToken);
    taskChecklists = ClickUpTaskChecklists(endPoint: apiEndpoint, authToken: auth.authToken);
    comments = ClickUpComments(endPoint: apiEndpoint, authToken: auth.authToken, httpClient: httpClient);
    customFields = ClickUpCustomFields(endPoint: apiEndpoint, authToken: auth.authToken);
    dependencies = ClickUpDependencies(endPoint: apiEndpoint, authToken: auth.authToken);
    folders = ClickUpFolders(endPoint: apiEndpoint, authToken: auth.authToken);
    goals = ClickUpGoals(endPoint: apiEndpoint, authToken: auth.authToken);
    guests = ClickUpGuests(endPoint: apiEndpoint, authToken: auth.authToken);
    lists = ClickUpLists(endPoint: apiEndpoint, authToken: auth.authToken);
    members = ClickUpMembers(endPoint: apiEndpoint, authToken: auth.authToken);
    roles = ClickUpRoles(endPoint: apiEndpoint, authToken: auth.authToken);
    sharedHierarchy = ClickUpSharedHierarchy(endPoint: apiEndpoint, authToken: auth.authToken);
    spaces = ClickUpSpaces(endPoint: apiEndpoint, authToken: auth.authToken);
    tags = ClickUpTags(endPoint: apiEndpoint, authToken: auth.authToken);
    tasks = ClickUpTasks(endPoint: apiEndpoint, authToken: auth.authToken);
    taskTemplates = ClickUpTaskTemplates(endPoint: apiEndpoint, authToken: auth.authToken);
    teams = ClickUpTeams(endPoint: apiEndpoint, authToken: auth.authToken);
    timeTrackingLegacy = ClickUpTimeTrackingLegacy(endPoint: apiEndpoint, authToken: auth.authToken);
    timeTrackingV2 = ClickUpTimeTrackingV2(endPoint: apiEndpoint, authToken: auth.authToken);
    users = ClickUpUsers(endPoint: apiEndpoint, authToken: auth.authToken);
    views = ClickUpViews(endPoint: apiEndpoint, authToken: auth.authToken);
    webhooks = ClickUpWebhooks(endPoint: apiEndpoint, authToken: auth.authToken);
    print("ClickUp Initialized..");
  }
}
