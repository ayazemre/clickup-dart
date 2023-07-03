import 'dart:convert';

import 'package:http/http.dart';

import '../clickup_exception.dart';

class ClickUpTasks {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpTasks(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});

  Future<Map<String, dynamic>> getTasks({
    required double listID,
    bool archived = false,
    int page = 0,
    String orderBy = "created",
    bool reverse = true,
    bool subtasks = true,
    String statuses = "",
    bool includeClosed = false,
    List<String> assignees = const [],
    List<String> tags = const [],
    int dueDateGreaterThan = 0,
    int dueDateLessThan = 0,
    int dateCreatedGreaterThan = 0,
    int dateCreatedLessThan = 0,
    int dateUpdatedGreaterThan = 0,
    int dateUpdatedLessThan = 0,
    int dateDoneGreaterThan = 0,
    int dateDoneLessThan = 0,
    List<Map<String, dynamic>> customFields = const [],
  }) async {
    ////TO:DO Parameter validation

    var assigneeQuery = "";
    var tagQuery = "";
    var customFieldQuery = "custom_fields=[${customFields.toString()}]";
    if (assignees.isNotEmpty) {
      for (var assignee in assignees) {
        assigneeQuery = "assignees[]=$assignee&";
        print(assigneeQuery.length);
        assigneeQuery = assigneeQuery.substring(0, assigneeQuery.length - 1);
      }
    }
    if (tags.isNotEmpty) {
      for (var tag in tags) {
        tagQuery = "tags[]=$tag&";
      }
      tagQuery = assigneeQuery.substring(0, assigneeQuery.length - 1);
    }

    final queryParams =
        "?archived=$archived&page=$page&order_by=$orderBy&reverse=$reverse&subtasks=$subtasks&statuses=$statuses&include_closed=$includeClosed&assignees=$assigneeQuery&tags=$tagQuery&due_date_gt=$dueDateGreaterThan&due_date_lt=$dueDateLessThan&date_created_gt=$dateCreatedGreaterThan&date_created_lt=$dateCreatedLessThan&date_updated_gt=$dateUpdatedGreaterThan&date_updated_lt=$dateUpdatedLessThan&date_done_gt=$dateDoneGreaterThan&date_done_lt=$dateDoneGreaterThan&custom_fields=$customFieldQuery";
    try {
      final response = await httpClient.get(
          Uri.parse("$endPoint/list/$listID/task$queryParams"),
          headers: {"Authorization": authToken});
      final List tasks = jsonDecode(response.body);
      return tasks.first;
    } catch (e) {
      print(e);
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Sample Task Schema
  /// ```
  /// {
  ///      "name": "",
  ///      "description": "",
  ///      "assignees": [], //List of integers
  ///      "tags": [], //List of Strings
  ///      "status": "",
  ///      "priority": 0,
  ///      "due_date": 0,
  ///      "due_date_time": false,
  ///      "time_estimate": 0,
  ///      "start_date": 0,
  ///      "start_date_time": false,
  ///      "notify_all": false,
  ///      "parent": "",
  ///      "links_to": "",
  ///      "check_required_custom_fields": false,
  ///      "custom_fields": [] // List of Maps
  ///    }
  /// ```

  Future<Map<String, dynamic>> createTask({
    required double listID,
    required Map<String, dynamic> taskDescription,
    bool customTaskIDs = false,
    double teamID = 0,
  }) async {
    ////TO:DO Parameter validation

    var queryParams = "";
    if (customTaskIDs) {
      queryParams = "?${queryParams}custom_task_ids=true";
      if (teamID != 0) {
        queryParams = "$queryParams&team_id=$teamID";
      }
    }

    try {
      final response = await httpClient.post(
          Uri.parse("$endPoint/list/$listID/task$queryParams"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(taskDescription));
      final task = jsonDecode(response.body);
      return task;
    } catch (e) {
      print(e);
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> getTask(
      {required double taskID,
      bool customTaskIDs = false,
      double teamID = 0,
      bool includeSubtasks = false}) async {
    ////TO:DO Parameter validation

    var queryParams = "";
    if (customTaskIDs && teamID != 0) {
      queryParams = "?${queryParams}custom_task_ids=true&team_id=$teamID";
      if (includeSubtasks) {
        queryParams = "$queryParams&include_subtasks=true";
      }
    } else if (includeSubtasks) {
      queryParams = "?include_subtasks=true";
    }

    try {
      final response = await httpClient
          .get(Uri.parse("$endPoint/task/$taskID$queryParams"), headers: {
        "Authorization": authToken,
      });
      final task = jsonDecode(response.body);
      return task;
    } catch (e) {
      print(e);
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Sample Task Schema
  /// ```
  ///    {
  ///      "name": "",
  ///      "description": "",
  ///      "status": "",
  ///      "priority": 0,
  ///      "due_date": 0,
  ///      "due_date_time": false,
  ///      "parent": "",
  ///      "time_estimate": 0,
  ///      "start_date": 0,
  ///      "start_date_time": false,
  ///      "assignees": {
  ///        "add": [],
  ///        "rem": []
  ///      }, //List of integers
  ///      "archived": false
  ///    }
  /// ```
  Future<Map<String, dynamic>> updateTask({
    required double taskID,
    required Map<String, dynamic> taskDescription,
    bool customTaskIDs = false,
    double teamID = 0,
  }) async {
    ////TO:DO Parameter validation

    var queryParams = "";
    if (customTaskIDs) {
      queryParams = "?${queryParams}custom_task_ids=true";
      if (teamID != 0) {
        queryParams = "$queryParams&team_id=$teamID";
      }
    }

    try {
      final response = await httpClient.put(
          Uri.parse("$endPoint/task/$taskID$queryParams"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(taskDescription));
      final task = jsonDecode(response.body);
      return task;
    } catch (e) {
      print(e);
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> deleteTask({
    required double taskID,
    bool customTaskIDs = false,
    double teamID = 0,
  }) async {
    ////TO:DO Parameter validation

    var queryParams = "";
    if (customTaskIDs) {
      queryParams = "?${queryParams}custom_task_ids=true";
      if (teamID != 0) {
        queryParams = "$queryParams&team_id=$teamID";
      }
    }

    try {
      final response = await httpClient
          .delete(Uri.parse("$endPoint/task/$taskID$queryParams"), headers: {
        "Authorization": authToken,
        "Content-Type": "application/json"
      });
      final task = jsonDecode(response.body);
      return task;
    } catch (e) {
      print(e);
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Order by Options include: id, created, updated, and due_date.
  Future<Map<String, dynamic>> getFilteredTeamTasks({
    required double workspaceTeamID,
    int page = 0,
    String orderBy = "created",
    bool reverse = false,
    bool subtasks = false,
    List<String> spaceIDs = const [],
    List<String> projectIDs = const [],
    List<String> listIDs = const [],
    List<String> statuses = const [],
    bool includeClosed = false,
    List<String> assignees = const [],
    List<String> tags = const [],
    int dueDateGreaterThan = 0,
    int dueDateLessThan = 0,
    int dateCreatedGreaterThan = 0,
    int dateCreatedLessThan = 0,
    int dateUpdatedGreaterThan = 0,
    int dateUpdatedLessThan = 0,
    int dateDoneGreaterThan = 0,
    int dateDoneLessThan = 0,
    List<Map<String, dynamic>> customFields = const [],
    bool customTaskIDs = false,
    double teamID = 0,
    String parent = "",
  }) async {
    ////TO:DO Parameter validation
    var spaceIDsQuery = "";
    var projectIDsQuery = "";
    var listIDsQuery = "";
    var statusesQuery = "";
    var assigneesQuery = "";
    var tagsQuery = "";
    var customFieldsQuery = "";

    var queryParams =
        "?page=$page&order_by=$orderBy&reverse=$reverse&subtasks=$subtasks&space_ids=$spaceIDsQuery&project_ids=$projectIDsQuery&list_ids=$listIDsQuery&statuses=$statusesQuery&include_closed=$includeClosed&assignees=$assigneesQuery&tags=$tagsQuery&due_date_gt=$dueDateGreaterThan&due_date_lt=$dueDateLessThan&date_created_gt=$dateCreatedGreaterThan&date_created_lt=$dateCreatedLessThan&date_updated_gt=$dateUpdatedGreaterThan&date_updated_lt=$dateUpdatedLessThan&date_done_gt=$dateDoneGreaterThan&date_done_lt=$dateDoneLessThan&custom_fields=$customFieldsQuery";
    if (customTaskIDs) {
      queryParams = "${queryParams}custom_task_ids=true";
      if (teamID != 0) {
        queryParams = "$queryParams&team_id=$teamID";
      }
    }
    if (parent.isNotEmpty) {
      queryParams = "$queryParams&parent=string";
    }

    try {
      final response = await httpClient.get(
          Uri.parse("$endPoint/team/$workspaceTeamID/task$queryParams"),
          headers: {
            "Authorization": authToken,
          });
      final task = jsonDecode(response.body);
      return task;
    } catch (e) {
      print(e);
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> getTasksTimeInStatus({
    required String taskID,
    bool customTaskIDs = false,
    double teamID = 0,
  }) async {
    ////TO:DO Parameter validation

    var queryParams = "";
    if (customTaskIDs) {
      queryParams = "?${queryParams}custom_task_ids=true";
      if (teamID != 0) {
        queryParams = "$queryParams&team_id=$teamID";
      }
    }

    try {
      final response = await httpClient.get(
          Uri.parse("$endPoint/task/$taskID/time_in_status$queryParams"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          });
      final task = jsonDecode(response.body);
      return task;
    } catch (e) {
      print(e);
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> getBulkTasksTimeInStatus({
    required List<String> taskIDs,
    bool customTaskIDs = false,
    double teamID = 0,
  }) async {
    if (taskIDs.length > 99) {
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.invalidModel,
          exceptionMessage: "You can only query up to 100 tasks per request");
    }
    ////TO:DO Parameter validation
    var queryParams = "?";
    final template = "task_ids=";
    for (var taskID in taskIDs) {
      queryParams = "$queryParams$template$taskID&";
    }
    if (customTaskIDs) {
      queryParams = "${queryParams}custom_task_ids=true";
      if (teamID != 0) {
        queryParams = "$queryParams&team_id=$teamID";
      }
    }
    if (queryParams.isNotEmpty) {
      queryParams = queryParams.substring(0, queryParams.length - 1);
    }

    try {
      final response = await httpClient.get(
          Uri.parse("$endPoint/task/bulk_time_in_status/task_ids$queryParams"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          });
      final task = jsonDecode(response.body);
      return task;
    } catch (e) {
      print(e);
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
