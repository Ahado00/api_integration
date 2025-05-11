import 'package:api_integration/post.dart';
import 'package:api_integration/post_card.dart';
import 'package:flutter/material.dart';

import 'dio_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Posts Example',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: PostListScreen(),
    );
  }

}

class PostListScreen extends StatelessWidget {
  final DioService dioService = DioService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Posts")),
      body: FutureBuilder<List<Post>>(
        future: dioService.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return PostCard(post: post);
              },
            );
          }
        },
      ),
    );
  }
}




