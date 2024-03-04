import 'package:http/http.dart' as http;
import 'package:tdd_mvc/model/post.dart';
import 'package:tdd_mvc/utils/app_constants.dart';

class PostsController {
  final http.Client client;
  PostsController(this.client);

  Future<List<Post>> getPosts() async {
    final response = await client.get(Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodPosts));

    if(response.statusCode == 200) {
      return parsePosts(response.body);
    } else {
      return [];
    }
  }
}