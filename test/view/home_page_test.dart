import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_mvc/controller/posts_controller.dart';
import 'package:tdd_mvc/model/post.dart';
import 'package:tdd_mvc/utils/app_constants.dart';
import 'package:tdd_mvc/view/home_page.dart';

class MockController extends Mock implements PostsController {}
class MockClient extends Mock implements Client {}

void main() {
  late MockClient mockClient;
  late MockController mockController;
  late List<Post> mockPosts;

  setUpAll(() {
    mockClient = MockClient();
    mockController = MockController();

    mockPosts = [
      Post(userId: 1, id: 1, title: 'Post 1', body: 'Body of Post 1', link: 'https://example.com', commentCount: 5),
      Post(userId: 2, id: 2, title: 'Post 2', body: 'Body of Post 2', link: 'https://example.com', commentCount: 3),
    ];
  });

  Future<List<Post>> convertToFuture(List<Post> posts) {
    return Future.value(posts);
  }

  testWidgets('given HomePage it should display AppBar with List of users', (tester) async {
    when(() => mockController.getPosts()).thenAnswer((_) async => mockPosts);

    // AsyncSnapshot<List<Post>>.withData(ConnectionState.done, mockPosts);

    await tester.pumpWidget(MaterialApp(
      home: HomePage(
        posts: convertToFuture(mockPosts),
      ),
    ));

    expect(find.text('HomePage'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await mockController.getPosts();

    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.pumpAndSettle();
    // expect(find.byType(ListView), findsOneWidget);

    expect(find.byType(ListTile), findsNWidgets(1));
  });

  testWidgets('given HomePage it should display error message when error occurs', (tester) async {
    AsyncSnapshot<List<Post>>.withError(ConnectionState.done, 'Test error');
    await tester.pumpWidget(MaterialApp(
      home: HomePage(
        posts: convertToFuture(mockPosts),
      ),
    ));

    await tester.pumpAndSettle();
    expect(find.text('No data found!'), findsOneWidget);
  });
}