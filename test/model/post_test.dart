import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_mvc/model/post.dart';

void main() {
  group('Post model test', () {
    test('creating a Post model with valid data should succeed', () {
      final post = Post(
        userId: 1,
        id: 1,
        title: 'Introduction to Artificial Intelligence',
        body: 'Learn the basics of Artificial Intelligence and its applications',
        link: 'https://example.com/article',
        commentCount: 8,
      );

      expect(post.userId, 1);
      expect(post.id, 1);
      expect(post.title, "Introduction to Artificial Intelligence");
      expect(post.body, "Learn the basics of Artificial Intelligence and its applications");
      expect(post.link, "https://example.com/article");
      expect(post.commentCount, 8);
    });

    test('creating a Post model with valid data should not match the final data', () {
      final post = Post(
        userId: 1,
        id: 1,
        title: 'Introduction to Artificial Intelligence',
        body: 'Learn the basics of Artificial Intelligence and its applications',
        link: 'https://example.com/article',
        commentCount: 8,
      );

      expect(post.userId, isNot(equals(0)));
      expect(post.id, isNot(equals(0)));
      expect(post.title, isNot(equals("")));
      expect(post.body, isNot(equals("")));
      expect(post.link, isNot(equals("")));
      expect(post.commentCount, 8);
    });

    test('fromJson creates a Post object from valid JSON', () {
      final Map<String, dynamic> json = {
        'userId': 1,
        'id': 1,
        'title': 'Test Title',
        'body': 'Test Body',
        'link': 'https://example.com',
        'comment_count': 5,
      };

      final post = Post.fromJson(json);

      expect(post.userId, 1);
      expect(post.id, 1);
      expect(post.title, 'Test Title');
      expect(post.body, 'Test Body');
      expect(post.link, 'https://example.com');
      expect(post.commentCount, 5);
    });
  });
}
