import 'package:http/http.dart';

import 'core/endpoints/attachments.dart';
import 'core/endpoints/auth.dart';
import 'core/endpoints/task_checklists.dart';
import 'core/endpoints/comments.dart';
import 'core/endpoints/custom_fields.dart';
import 'core/endpoints/task_relationships.dart';
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
  late final ClickUpComments comments;
  late final ClickUpCustomFields customFields;
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
  late final ClickUpTaskRelationships taskRelationships;
  late final ClickUpTaskChecklists taskChecklists;
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
    attachments = ClickUpAttachments(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    comments = ClickUpComments(endPoint: apiEndpoint, authToken: auth.authToken, httpClient: httpClient);
    customFields = ClickUpCustomFields(endPoint: apiEndpoint, authToken: auth.authToken, httpClient: httpClient);
    folders = ClickUpFolders(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    goals = ClickUpGoals(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    guests = ClickUpGuests(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    lists = ClickUpLists(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    members = ClickUpMembers(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    roles = ClickUpRoles(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    sharedHierarchy = ClickUpSharedHierarchy(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    spaces = ClickUpSpaces(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    tags = ClickUpTags(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    tasks = ClickUpTasks(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    taskChecklists = ClickUpTaskChecklists(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    taskRelationships = ClickUpTaskRelationships(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    taskTemplates = ClickUpTaskTemplates(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    teams = ClickUpTeams(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    timeTrackingLegacy = ClickUpTimeTrackingLegacy(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    timeTrackingV2 = ClickUpTimeTrackingV2(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    users = ClickUpUsers(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    views = ClickUpViews(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    webhooks = ClickUpWebhooks(endPoint: apiEndpoint, authToken: authToken, httpClient: httpClient);
    print("ClickUp Initialized..");
  }
}
