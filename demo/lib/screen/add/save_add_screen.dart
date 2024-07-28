import 'package:demo/app/dimensions.dart';
import 'package:demo/controller/post_controller.dart';
import 'package:demo/screen/add/hienthi.dart';
import 'package:demo/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'package:demo/models/post_model.dart';

class SaveAddScreen extends StatefulWidget {
  final String imagePath;
  final IO.Socket? socket;

  SaveAddScreen({required this.imagePath, this.socket});

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

  // Kiểm tra tệp có tồn tại hay không
  void _checkFileExist() async {
    final file = File(widget.imagePath);
    bool isExist = await file.exists();
    setState(() {
      _isFileExist = isExist;
    });
  }

  // Lưu dữ liệu và chuyển sang màn hình hiển thị bài đăng mới
  void _saveData() {
    if (!_isFileExist) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File không tồn tại!')));
      return;
    }

    final bytes = File(widget.imagePath).readAsBytesSync();
    final image = base64Encode(bytes);
    final caption = _captionController.text;
    final now = DateTime.now();

    final newPost = Post(
      image: image,
      avatar: '', // Đường dẫn ảnh đại diện mặc định
      name: 'User Name', // Thay thế bằng tên thực tế của người dùng
      time: DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
      caption: caption,
      likes: 0,
      comments: 0,
      isFavorite: false,
    );

    // Thêm bài đăng mới vào PostController
    Provider.of<PostController>(context, listen: false).addPostAtTop(newPost);

    // Chuyển sang màn hình hiển thị bài đăng mới
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HienThi(post: newPost),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a caption',
          style: TextStyle(
            color: Colors.black,
            fontSize: Dimensions.font20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_isFileExist)
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
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
                  labelStyle: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF2E7D5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 16.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _saveData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Đăng Ảnh',
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
