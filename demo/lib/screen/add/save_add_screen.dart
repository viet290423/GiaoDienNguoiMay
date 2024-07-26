import 'package:demo/screen/add/hienthi.dart';
import 'package:demo/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'hienthi.dart';
import 'package:demo/models/post_model.dart';



class SaveAddScreen extends StatefulWidget {
  final String imagePath;
  final IO.Socket? socket;
  

  SaveAddScreen({required this.imagePath, required this.socket});

  @override
  _SaveAddScreenState createState() => _SaveAddScreenState();
}

class _SaveAddScreenState extends State<SaveAddScreen> {
  TextEditingController _captionController = TextEditingController();
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
    final image = base64Encode(bytes);
    final caption = _captionController.text;

    widget.socket
        ?.emit('save_image', {'image': image, 'caption': caption});
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Data sent to server')));

    // Chuyển sang màn hình hiển thị ảnh và caption
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HienThi(
            image: image,
            caption: caption,
            time: DateTime.now()),
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
                controller: _captionController,
                decoration: InputDecoration(
                  labelText: 'Caption',
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
