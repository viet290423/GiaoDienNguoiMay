import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

class HienThi extends StatefulWidget {
  final String image;
  final String caption;
  final DateTime time;

  const HienThi(
      {super.key, required this.image,
      required this.caption,
      required this.time});

  @override
  _HienThiState createState() => _HienThiState();
}

class _HienThiState extends State<HienThi> {
  late Timer _timer;
  final ValueNotifier<String> _elapsedTimeNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _updateElapsedTime();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateElapsedTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    _elapsedTimeNotifier.dispose();
    super.dispose();
  }

  void _updateElapsedTime() {
    final now = DateTime.now();
    final difference = now.difference(widget.time);

    // Cập nhật thời gian đã trôi qua mỗi giây
    if (difference.inSeconds < 60) {
      _elapsedTimeNotifier.value = '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes < 60) {
      _elapsedTimeNotifier.value = '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      _elapsedTimeNotifier.value = '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      _elapsedTimeNotifier.value = '${difference.inDays} ngày trước';
    } else {
      _elapsedTimeNotifier.value =
          '${(difference.inDays / 7).floor()} tuần trước';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiển Thị Ảnh'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(
              // Chuyển đổi chuỗi hình ảnh base64 thành Uint8List
              Base64Decoder().convert(widget.image),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Caption: ${widget.caption}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ValueListenableBuilder<String>(
              valueListenable: _elapsedTimeNotifier,
              builder: (context, elapsedTime, child) {
                return Text(
                  ' $elapsedTime',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
