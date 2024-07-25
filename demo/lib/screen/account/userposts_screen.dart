import 'package:flutter/material.dart';

class UserPostsScreen extends StatelessWidget {
  final String userName;
  final List<Map<String, dynamic>> posts;

  UserPostsScreen({required this.userName, required this.posts});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> userPosts = posts
        .where((post) => post['name'] == userName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: ListView.builder(
        itemCount: userPosts.length,
        itemBuilder: (context, index) {
          final post = userPosts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(post['avatar']),
            ),
            title: Text(post['caption']),
            subtitle: Text(post['time']),

          );
        },
      ),
    );
  }
}
