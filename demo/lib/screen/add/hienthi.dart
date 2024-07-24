import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HienThi extends StatelessWidget {
  final String imageBase64;
  final String comment;
  final DateTime createdAt;

  HienThi({required this.imageBase64, required this.comment, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    // Chuyển đổi thời gian từ UTC sang múi giờ địa phương
    final localTime = createdAt.toLocal();

    // Định dạng thời gian để hiển thị
    final formattedTime = DateFormat.yMd().add_jms().format(localTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hiển Thị Ảnh'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(
              // Convert base64 image string to Uint8List
              Base64Decoder().convert(imageBase64),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Comment: $comment',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Created at: $formattedTime',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
