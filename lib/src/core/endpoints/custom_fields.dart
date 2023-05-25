import 'dart:convert';
import 'package:clickup_dart_sdk/src/core/clickup_exception.dart';
import 'package:http/http.dart';

enum CustomFieldType { url, number }

class ClickUpCustomFields {
  late String endPoint;
  late String authToken;
  late Client httpClient;

  ClickUpCustomFields(
      {required this.endPoint,
      required this.authToken,
      required this.httpClient});

  Future<Map<String, dynamic>> getAccessibleCustomFields(
      {required String listID}) async {
    try {
      final response = await httpClient
          .get(Uri.parse("$endPoint/list/$listID/field"), headers: {
        "Authorization": authToken,
        "Content-Type": "application/json"
      });
      final customFields = jsonDecode(response.body);
      return customFields;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  /// Sets the Custom Field to functions value parameter. You'll need to know the "task_id" of the task you want to update, and the universal unique identifier (UUID) "field_id" of the Custom Field you want to set. Value must be one of the following depending of the field type;
  ///
  /// URL Custom Field:
  /// ```
  /// {
  /// "value": "This is sample URL",  // Should be String.
  /// }
  /// ```
  ///
  /// Dropdown Custom Field:
  ///
  /// Enter the universal unique identifier (UUID) of the dropdown menu option you want to set. You can find the UUIDs available for each getAccessibleCustomFields function.
  /// ```
  /// {
  /// "value": "03efda77-c7a0-42d3-8afd-fd546353c2f5",  // Should be String.
  /// }
  /// ```
  ///
  /// Email Custom Field:
  /// ```
  /// {
  /// "value": "example@example.com",  // Should be String.
  /// }
  /// ```
  ///
  /// Phone Custom Field:
  /// ```
  /// {
  /// "value": "+0 123 456 78 90",  // Should be String.
  /// }
  /// ```
  ///
  /// Date Custom Field:
  ///
  /// The value must be Unix time in milliseconds. To display the time in a Date Custom Field in ClickUp, you must include time: true in the value_options property.
  /// ```
  /// {
  /// "value":123456787,  // Should be int.
  /// "value_options": {"time": true}  // Should be an Map.
  /// }
  /// ```
  ///
  /// Short or Long Text Custom Field:
  /// ```
  /// {
  /// "value": "This is a sample text",  // Should be String.
  /// }
  /// ```
  ///
  /// Number Custom Field:
  /// ```
  /// {
  /// "value": 12345678,  // Should be int.
  /// }
  /// ```
  ///
  /// Money Custom Field:
  ///
  /// You can set an amount, but not the currency of a Money Custom Field via the SDK. You can check the currency of a Money Custom Field using getAccessibleCustomFields function.
  /// ```
  /// {
  /// "value": 12345678,  // Should be int.
  /// }
  /// ```
  ///
  /// Task Relationship Custom Field:
  ///
  /// Enter an array of task ids in the "add" property to add them to a Task Relationship Custom Field. Enter them into the "rem" property to remove tasks from the Relationship.
  /// ```
  /// {
  /// "value": {
  ///   "add": [
  ///     "abcd1234", // Should be String.
  ///     "efghi5678" // Should be String.
  ///    ],
  ///    "rem": [
  ///       "jklm9876", // Should be String.
  ///       "yuiop5678" // Should be String.
  ///     ]
  ///   }
  /// }
  /// ```
  /// People Custom Field:
  ///
  /// Enter an array of user ids in the add property to "add" them to a People Custom Field. Enter them into the "rem" property to remove users from a People Custom Field. You can get a list of people in the Workspace using getAuthorizedTeams function in workspaces.
  /// ```
  /// {
  ///  "value": {
  ///    "add": [
  ///      123, // Should be int.
  ///      456  // Should be int.
  ///    ],
  ///    "rem": [
  ///      987, // Should be int.
  ///      765  // Should be int.
  ///    ]
  ///  }
  /// }
  /// ```
  /// Emoji (Rating) Custom Field:
  ///
  /// Enter an integer that is greater than or equal to zero and where the count property is greater than or equal to the value. You can find the count property for each Emoji (Rating) Custom Field using getAccessibleCustomFields function.
  /// ```
  /// {
  /// "value": 12345678,  // Should be int.
  /// }
  /// ```
  /// Manual Progress Custom Field:
  ///
  /// Enter a number between the "start" and "end" values of each Manual Progress Custom Field. For example, for a field with "start": "10" and "end": "30", sending "current": "20" will be displayed as 50% complete in ClickUp. You can find the start and end values for each Manual Progress Custom Field using getAccessibleCustomFields function.
  /// ```
  /// {
  ///   "value": {
  ///     "current": 50 // Should be int.
  ///     },  // Should be an Map.
  /// }
  /// ```
  ///
  /// Label Custom Field:
  ///
  /// Enter an array of the universal unique identifiers (UUIDs) of the labels you want to apply. You can find the UUIDs available for each Label Custom Field using getAccessibleCustomFields function.
  /// ```
  /// {
  /// "value": ["03efda77-c7a0-42d3-8afd-fd546353c2f5", "30efda77-c7a0-42d3-8afd-fd546353c4a3"],  // Should be array of Strings.
  /// }
  /// ```
  ///
  /// Location Custom Field:
  ///
  /// Include the latitude, longitude, and formatted address as defined in the Google Maps Geocoding API.
  /// ```
  /// {
  /// "value":{
  ///   "location": {
  ///     "lat": 1234,  // Should be int.
  ///     "lng": 1234 // Should be int.
  ///     },  // Should be Map.
  ///   "formatted_address":"This is a sample address." // Should be String.
  ///   },  // Should be Map.
  /// }
  /// ```
  Future<Map<String, dynamic>> setCustomFieldValue(
      {required String taskID,
      required String fieldID,
      required Map<String, dynamic> value,
      bool customTaskID = false,
      double? teamID}) async {
    if (!value.containsKey("value")) {
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.invalidModel,
          exceptionMessage:
              "Your value model is invalid. Please read the function documentation.");
    }

    try {
      final response = await httpClient.post(
          Uri.parse(customTaskID
              ? "$endPoint/task/$taskID/field/$fieldID?custom_task_ids=true&team_id=$teamID"
              : "$endPoint/task/$taskID/field/$fieldID"),
          headers: {
            "Authorization": authToken,
            "Content-Type": "application/json"
          },
          body: jsonEncode(value));
      final customFieldResponse = jsonDecode(response.body);
      return customFieldResponse;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> removeCustomFieldValue(
      {required String taskID,
      required String fieldID,
      bool customTaskID = false,
      double? teamID}) async {
    try {
      final response = await httpClient.delete(
        Uri.parse(customTaskID
            ? "$endPoint/task/$taskID/field/$fieldID?custom_task_ids=true&team_id=$teamID"
            : "$endPoint/task/$taskID/field/$fieldID"),
        headers: {
          "Authorization": authToken,
          "Content-Type": "application/json"
        },
      );
      final customFieldResponse = jsonDecode(response.body);
      return customFieldResponse;
    } catch (e) {
      print(e.toString());
      throw ClickUpException(
          exceptionType: ClickUpExceptionType.requestError,
          exceptionMessage:
              "An error occured while making the request. Error is ${e.toString()}");
    }
  }
}
