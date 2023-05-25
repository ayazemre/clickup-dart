import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('Tasks Tests', () {
    setUp(() async {
      // Additional setup goes here.
      token = "pk_qwerty123456";
      clickUp = ClickUp(apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")..initialize(authToken: token);
    });

    test('Tasks - Get Tasks', () async {
      final tasks = await clickUp.tasks.getTasks(listID: 1);
      print(tasks);
      expect(tasks.containsKey("tasks"), true);
    });
    test('Tasks - Create Task', () async {
      final task = await clickUp.tasks.createTask(listID: 1, taskDescription: {
        "name": "",
        "description": "",
        "assignees": [], //List of integers
        "tags": [], //List of Strings
        "status": "",
        "priority": 0,
        "due_date": 0,
        "due_date_time": false,
        "time_estimate": 0,
        "start_date": 0,
        "start_date_time": false,
        "notify_all": false,
        "parent": "",
        "links_to": "",
        "check_required_custom_fields": false,
        "custom_fields": [] // List of Maps
      });
      print(task);
      expect(task.containsKey("id"), true);
    });
    test('Tasks - Get Specific Task ', () async {
      final task = await clickUp.tasks.getTask(taskID: 1);
      print(task);
      expect(task.containsKey("id"), true);
    });

    test('Tasks - Update Task', () async {
      final task = await clickUp.tasks.updateTask(taskID: 1, taskDescription: {
        "name": "",
        "description": "",
        "status": "",
        "priority": 0,
        "due_date": 0,
        "due_date_time": false,
        "parent": "",
        "time_estimate": 0,
        "start_date": 0,
        "start_date_time": false,
        "assignees": {
          "add": [],
          "rem": []
        }, //List of integers
        "archived": false
      });
      print(task);
      expect(task.containsKey("id"), true);
    });
    test('Tasks - Delete Task', () async {
      final task = await clickUp.tasks.deleteTask(taskID: 1);
      print(task);
      expect(task.isEmpty, true);
    });
    test('Tasks - Get Filtered Team Tasks', () async {
      final task = await clickUp.tasks.getFilteredTeamTasks(workspaceTeamID: 1);
      print(task);
      expect(task.containsKey("tasks"), true);
    });
    test('Tasks - Get Tasks Time In Status', () async {
      final task = await clickUp.tasks.getTasksTimeInStatus(taskID: "1");
      print(task);
      expect(task.containsKey("current_status"), true);
    });
    test('Tasks - Get Bulk Tasks Time In Status', () async {
      final task = await clickUp.tasks.getBulkTasksTimeInStatus(taskIDs: [
        "1",
        "2"
      ]);
      print(task);
      final result = task.values.first as Map;
      expect(result.containsKey("current_status"), true);
    });
  });
}
