import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_mvc/controller/posts_controller.dart';
import 'package:tdd_mvc/model/post.dart';
import 'package:tdd_mvc/utils/app_constants.dart';

class MockClient extends Mock implements Client {}

void main() {
  late PostsController postsController;
  late MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    postsController = PostsController(mockClient);
  });

  group('Testing Post Controller', () {
    test('given getPosts method when called should return valid data of posts', () async {
      when(() => mockClient.get(Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodPosts))).thenAnswer((invocation) async {
        return Response(
          '''
          [
            {
                "userId": 1,
                "id": 1,
                "title": "Introduction to Artificial Intelligence",
                "body": "Learn the basics of Artificial Intelligence and its applications in various industries.",
                "link": "https://example.com/article1",
                "comment_count": 8
            }
          ]
          ''', 200
        );
      });

      final posts = await postsController.getPosts();
      expect(posts, isA<List<Post>>());
    });
  });
}