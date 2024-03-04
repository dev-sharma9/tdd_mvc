import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdd_mvc/controller/posts_controller.dart';
import 'package:tdd_mvc/model/post.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.posts});
  Future<List<Post>>? posts;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final postsController = PostsController(http.Client());

  @override
  void initState() {
    super.initState();
    widget.posts = postsController.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage'),
      ),
      body: FutureBuilder<List<Post>>(
        future: widget.posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data found!'),
            );
          } else {
            List<Post> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Post post = posts[index];
                return ListTile(
                  title: Text(
                    post.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Text(
                    post.body!,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
