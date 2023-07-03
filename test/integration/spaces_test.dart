import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('Spaces Tests', () {
    setUp(() async {
      // Additional setup goes here.
      token = "pk_qwerty123456";
      clickUp = ClickUp(
          apiEndpoint:
              "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")
        ..initialize(authToken: token);
    });

    test('Spaces - Get Spaces', () async {
      final spaces = await clickUp.spaces.getSpaces(teamID: 123);
      print(spaces);
      expect(spaces.containsKey("spaces"), true);
    });
    test('Spaces - Get Spaces: Include Archived', () async {
      final spaces =
          await clickUp.spaces.getSpaces(teamID: 123, includeArchived: true);
      expect(spaces.containsKey("spaces"), true);
    });
    test('Spaces - Create Space', () async {
      final space = await clickUp.spaces.createSpace(
          teamID: 123, spaceSchema: clickUp.spaces.sampleSpaceSchema);
      expect(space.containsKey("features"), true);
    });
    test('Spaces - Get Space', () async {
      final space = await clickUp.spaces.getSpace(spaceID: 123);
      expect(space.containsKey("features"), true);
    });
    test('Spaces - Update Space', () async {
      final space =
          await clickUp.spaces.updateSpace(spaceID: 123, spaceSchema: {
        ...clickUp.spaces.sampleSpaceSchema,
        ...{"color": "blue", "private": false, "admin_can_manage": false}
      });
      expect(space.containsKey("features"), true);
    });
    test('Spaces - Delete Space', () async {
      final space = await clickUp.spaces.deleteSpace(spaceID: 123);
      expect(space.isEmpty, true);
    });
  });
}
