import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('Authorization Tests', () {
    setUp(() async {
      // Setting up the SDK with a random token and mock server. ClickUp's official mock server accepts random tokens as valid tokens.
      token = "pk_qwerty123456";
      clickUp = ClickUp(apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")..initialize(authToken: token);
    });

    test('Authorization - Get Authorized User', () async {
      final user = await clickUp.auth.getAuthorizedUser();
      expect(user.containsKey("user"), true);
    });
    test('Authorization - Get Authorized Teams(Workspaces)', () async {
      final teams = await clickUp.auth.getAuthorizedTeams();
      expect(teams.containsKey("teams"), true);
    });
  });
}
