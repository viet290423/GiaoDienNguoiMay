import 'dart:convert';

import 'package:flutter/material.dart';

class Post {
  String image;
  MemoryImage? decodedImage;
  String avatar;
  String name;
  String time;
  String caption;
  int likes;
  int comments;
  bool isFavorite;
  bool isAssetImage; // Thêm trường này để xác định loại ảnh

  Post({
    required this.image,
    this.decodedImage,
    required this.avatar,
    required this.name,
    required this.time,
    required this.caption,
    required this.likes,
    required this.comments,
    this.isFavorite = false,
    this.isAssetImage = true, // Mặc định là ảnh từ assets
  });

  static List<Post> generatePosts() {
    return [
      Post(
        image: 'assets/images/anh1.jpg',
        avatar: 'assets/images/flowers.png',
        name: 'Hoa',
        time: '2 min ago',
        caption: 'Guess where I am??',
        likes: 1200,
        comments: 1200,
      ),
      Post(
        image: 'assets/images/flowers.png',
        avatar: 'assets/images/labubu1.webp',
        name: 'Minh Quan',
        time: '5 min ago',
        caption: 'Just chilling here!',
        likes: 800,
        comments: 500,
      ),
      Post(
        image: 'assets/images/labubu3.jpg',
        avatar: 'assets/images/labubu6.webp',
        name: 'Minh',
        time: '5 min ago',
        caption: 'Labutuuuuuuu ahuhuu!',
        likes: 800,
        comments: 500,
      ),
    ];
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    bool isAssetImage = map['isAssetImage'] ?? false;
    return Post(
      name: map['name'],
      avatar: map['avatar'],
      time: map['time'],
      image: map['image'],
      decodedImage: !isAssetImage && map['image'] != null
          ? MemoryImage(base64Decode(map['image']))
          : null,
      caption: map['caption'],
      likes: map['likes'],
      comments: map['comments'],
      isFavorite: map['isFavorite'],
      isAssetImage: isAssetImage ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'avatar': avatar,
      'name': name,
      'time': time,
      'caption': caption,
      'likes': likes,
      'comments': comments,
      'isFavorite': isFavorite,
      'isAssetImage': isAssetImage,
    };
  }
}
