import 'package:demo/screen/hienthi.dart';
import 'package:demo/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart'; // Để sử dụng định dạng thời gian
import 'hienthi.dart';
 // Import file hienthi.dart để sử dụng class HienThi

class SaveAddScreen extends StatefulWidget {
  final String imagePath;
  final IO.Socket? socket;

  SaveAddScreen({required this.imagePath, required this.socket});

  @override
  _SaveAddScreenState createState() => _SaveAddScreenState();
}

class _SaveAddScreenState extends State<SaveAddScreen> {
  TextEditingController _commentController = TextEditingController();
  bool _isFileExist = false;

  @override
  void initState() {
    super.initState();
    _checkFileExist();
  }

  void _checkFileExist() async {
    final file = File(widget.imagePath);
    bool isExist = await file.exists();
    setState(() {
      _isFileExist = isExist;
    });
  }

  void _saveData() {
    if (!_isFileExist) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File không tồn tại!')));
      return;
    }

    final bytes = File(widget.imagePath).readAsBytesSync();
    final base64Image = base64Encode(bytes);
    final comment = _commentController.text;

    widget.socket?.emit('save_image', {'image': base64Image, 'comment': comment});
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Data sent to server')));

    // Chuyển sang màn hình hiển thị ảnh và comment
    // Thay vì truyền null vào createdAt, chúng ta sẽ truyền DateTime.now()
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HienThi(imageBase64: base64Image, comment: comment, createdAt: DateTime.now()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lưu Ảnh'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_isFileExist)
              Container(
                height: 350, // Đặt chiều cao của ảnh
                width: 350, // Đặt chiều rộng của ảnh
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Bo tròn góc ảnh
                  image: DecorationImage(
                    image: FileImage(File(widget.imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Text('Ảnh không tồn tại hoặc đường dẫn không hợp lệ'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Comment',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Đăng Ảnh'),
            ),
          ],
        ),
      ),
    );
  }
}
