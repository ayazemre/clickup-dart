import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:clickup_dart_sdk/src/core/clickup_exception.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;

  group('Custom Fields Tests', () {
    setUp(() async {
      // Setting up the SDK with a random token and mock server. ClickUp's official mock server accepts random tokens as valid tokens.
      token = "pk_qwerty123456";
      clickUp = ClickUp(apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")..initialize(authToken: token);
    });
    // Tests are run for just getting the fields and updating the URL field. Remaining field types are dependent on the model and all of the models actually return success. This means testing for only one field type should be enough.
    test('Custom Fields - Get Accessible Custom Fields', () async {
      final customFields = await clickUp.customFields.getAccessibleCustomFields(listID: "1234");
      expect(customFields.containsKey("fields"), true);
    });

    test('Custom Fields - Set Custom Field Value - URL Custom Field', () async {
      final customField = await clickUp.customFields.setCustomFieldValue(fieldID: "1234", taskID: "1234", value: {
        "value": "https://ayazemre.com"
      });
      print(customField);
      expect(customField.isEmpty, true);
    });
    test('Custom Fields - Set Custom Field Value - URL Custom Field - Custom Task ID', () async {
      final customField = await clickUp.customFields.setCustomFieldValue(
          fieldID: "1234",
          taskID: "1234",
          value: {
            "value": "https://ayazemre.com"
          },
          customTaskID: true,
          teamID: 1234);
      expect(customField.isEmpty, true);
    });
    test('Custom Fields - Set Custom Field Value - Wrong Data Model', () async {
      expect(
          () async => await clickUp.customFields.setCustomFieldValue(
              fieldID: "1234",
              taskID: "1234",
              value: {
                "valeu": "https://ayazemre.com"
              },
              customTaskID: true,
              teamID: 1234),
          throwsA(isA<ClickUpException>()));
    });
    test('Custom Fields - Remove Custom Field Value', () async {
      final result = await clickUp.customFields.removeCustomFieldValue(fieldID: "1234", taskID: "1234");
      expect(result.isEmpty, true);
    });
    test('Custom Fields - Remove Custom Field Value - Custom Task ID', () async {
      final result = await clickUp.customFields.removeCustomFieldValue(fieldID: "1234", taskID: "1234", customTaskID: true, teamID: 1234);
      expect(result.isEmpty, true);
    });
  });
}
