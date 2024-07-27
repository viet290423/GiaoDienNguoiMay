import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:demo/models/post_model.dart';

class PostController extends ChangeNotifier {
  List<Post> _posts = Post.generatePosts();

  List<Post> get posts => _posts;

  void addPost(Post post) {
    // Giải mã hình ảnh từ Base64
    post.decodedImage = post.image.isNotEmpty 
        ? MemoryImage(base64Decode(post.image)) 
        : null;
    
    _posts.add(post);
    notifyListeners(); // Thông báo cho các listeners về sự thay đổi
  }

  void addPostAtTop(Post post) {
    // Giải mã hình ảnh từ Base64
    post.decodedImage = post.image.isNotEmpty 
        ? MemoryImage(base64Decode(post.image)) 
        : null;
    
    _posts.insert(0, post); // Thêm bài đăng vào đầu danh sách
    notifyListeners(); // Thông báo cho các listeners về sự thay đổi
  }

  List<Post> fetchPosts() {
    return _posts;
  }
}
