import 'package:clickup_dart_sdk/clickup_dart_sdk.dart';
import 'package:test/test.dart';

void main() {
  late String token;
  late ClickUp clickUp;
  group('User Behaviour Samples', () {
    setUp(() async {
      // Additional setup goes here.
      token = "pk_qwerty123456";
      clickUp = ClickUp(apiEndpoint: "https://a00fb6e0-339c-4201-972f-503b9932d17a.remockly.com")..initialize(authToken: token);
    });

    group("User Logs in, creates a task and uploads a file.", () {
      test('Authorization - Get Authorized User', () async {
        final user = await clickUp.auth.getAuthorizedUser();
        expect(user.containsKey("user"), true);
      });
    });
  });
}
