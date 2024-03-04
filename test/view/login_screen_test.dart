import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_mvc/controller/login_controller.dart';
import 'package:tdd_mvc/model/login_response.dart';
import 'package:tdd_mvc/utils/app_constants.dart';
import 'package:tdd_mvc/view/home_page.dart';
import 'package:tdd_mvc/view/login_screen.dart';

class MockClient extends Mock implements Client {}
class MockNavigationObserver extends Mock implements NavigatorObserver {}
class FakeRoute extends Fake implements Route {}

void main() {
  late MockClient mockClient;
  late LoginController loginController;
  late MockNavigationObserver mockObserver;

  setUpAll(() {
    mockClient = MockClient();
    loginController = LoginController(mockClient);
    mockObserver = MockNavigationObserver();
    registerFallbackValue(FakeRoute());
  });

  group('Login Screen containing TextFields and button', () {
    testWidgets('displays 2 text fields 1 for username and another for entering password with Elevated button',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.text('Login'), findsNWidgets(2));
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('Validating button and on click function', () {

    testWidgets('given login button when clicked validates with login API and opens next screen', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginScreen(),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.byKey(const Key('Login Button')));
      await tester.pumpAndSettle();

      // expect(find.byType(HomePage), findsOneWidget);
      verify(() => mockObserver.didPush(any(), any()));
      // expect(find.byType(HomePage), findsOneWidget);
    });

    /*testWidgets('onClickLogin navigates to home page on successful login',
          (WidgetTester tester) async {
        // Find and fill the login form fields
        final usernameField = find.text('Username');
        final passwordField = find.text('Password');
        await tester.enterText(usernameField, 'valid_username');
        await tester.enterText(passwordField, 'valid_password');

        // Find the login button and tap it
        final loginButton = find.text('Login');
        await tester.tap(loginButton);

        // Mock successful login response
        // when(() => loginController.loginUser('valid_username', 'valid_password')).thenAnswer((_) async => LoginResponse(success: "success", message: "message", token: "token").success);

        // Replace the actual loginController with the mock
        // await tester.pumpWidget(MyWidget(loginController: mo)); // Replace MyWidget with your actual widget type

        // Pump and settle to allow navigation to happen
        await tester.pumpAndSettle();

        // Verify that the home page is shown
        // expect(find.text('Home Page'), findsOneWidget);

        // Optionally, verify additional elements on the home page
        // based on the posts passed to the HomePage constructor
      },
    );*/

    // testWidgets('given login button when clicked validates with login API if failed shows snackBar', (tester) async {
    //   const username = "username";
    //   const password = "fail";
    //
    //   when(() => mockClient.post(
    //     Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodLogin),
    //     body: {"username": username, "password": password},
    //   )).thenAnswer((invocation) async {
    //     return Response('''
    //       {
    //           "success": false,
    //           "error": {
    //               "code": "invalid_credentials",
    //               "message": "Invalid username or password."
    //           }
    //       }
    //     ''', 200);
    //   });
    //
    //   await tester.pumpWidget(const MaterialApp(
    //     home: LoginScreen(),
    //   ));
    //
    //   await tester.tap(find.byKey(const Key('Login Button')));
    //   await tester.pumpAndSettle();
    //
    //   expect(find.byType(SnackBar), findsOneWidget);
    // });
  });
}
