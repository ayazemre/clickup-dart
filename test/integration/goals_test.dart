import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('Goals endpoint Tests', () {
    setUp(() async {
      // Additional setup goes here.
      token = "pk_qwerty123456";
      clickUp = ClickUp(apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")..initialize(authToken: token);
    });

    test('Goals - Get Goals', () async {
      final goals = await clickUp.goals.getGoals(teamID: 0);
      print(goals);
      expect(goals.containsKey("goals"), true);
    });
    test('Goals - Get Goals Include Completed', () async {
      final goals = await clickUp.goals.getGoals(teamID: 0, includeCompleted: true);
      print(goals);
      expect(goals.containsKey("goals"), true);
    });

    test('Goals - Create Goal', () async {
      final goal = await clickUp.goals.createGoal(teamID: 0, color: "red", description: "Hey", dueDate: 123456, goalName: "Test", multipleOwners: true, owners: [
        123,
        456,
        789
      ]);
      print(goal);
      expect(goal.containsKey("goal"), true);
    });
    test('Goals - Get Goal', () async {
      final goal = await clickUp.goals.getGoal(goalID: 0);
      print(goal);
      expect(goal.containsKey("goal"), true);
    });

    test('Goals - Update Goal', () async {
      final goal = await clickUp.goals.updateGoal(goalID: 0, color: "red", description: "Hey", dueDate: 123456, goalName: "Test", ownersToRemove: [
        123,
        456
      ], ownersToAdd: [
        789,
        146
      ]);
      print(goal);
      expect(goal.containsKey("goal"), true);
    });

    test('Goals - Delete Goal', () async {
      final goal = await clickUp.goals.deleteGoal(goalID: 0);
      print(goal);
      expect(goal.isEmpty, true);
    });
    test('Goals - Create Key Result', () async {
      final keyResult = await clickUp.goals.createKeyResult(goalID: 0, goalName: "test", type: "number", unit: "km", stepsStart: 0, stepsEnd: 2, owners: [
        0,
        1
      ], taskIDs: [
        "123",
        "456"
      ], listIDs: [
        "369",
        "741"
      ]);
      print(keyResult);
      expect(keyResult.containsKey("key_result"), true);
    });

    test('Goals - Edit Key Result', () async {
      final keyResult = await clickUp.goals.editKeyResult(keyResultID: 0, goalName: "test", type: "number", unit: "km", note: "hey", stepsStart: 0, stepsCurrent: 1, stepsEnd: 2, owners: [
        0,
        1
      ], taskIDs: [
        "123",
        "456"
      ], listIDs: [
        "369",
        "741"
      ]);
      print(keyResult);
      expect(keyResult.containsKey("key_result"), true);
    });

    test('Goals - Delete Key Result', () async {
      final keyResult = await clickUp.goals.deleteKeyResult(keyResultID: 0);
      print(keyResult);
      expect(keyResult.isEmpty, true);
    });
  });
}
