import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatDetailScreen extends StatefulWidget {
  final String userName;
  final String userImage;

  const ChatDetailScreen({super.key, required this.userName, required this.userImage});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = []; // Khởi tạo danh sách rỗng

  @override
  void initState() {
    super.initState();
    _initializeMessages();
  }

  Future<void> _initializeMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesString = prefs.getString('messages_${widget.userName}');

    if (messagesString != null) {
      // Nếu đã có tin nhắn từ SharedPreferences
      setState(() {
        _messages = List<Map<String, dynamic>>.from(jsonDecode(messagesString));
      });
    } else {
      // Nếu không có tin nhắn, sử dụng tin nhắn mẫu
      setState(() {
        _messages = [
          {"type": "received", "text": "Hi there!", "timestamp": DateTime.now().subtract(Duration(minutes: 60)).toIso8601String()},
          {"type": "sent", "text": "Hello!", "timestamp": DateTime.now().subtract(Duration(minutes: 59)).toIso8601String()},
          {"type": "received", "text": "What your name?", "timestamp": DateTime.now().subtract(Duration(minutes: 58)).toIso8601String()},
        ];
      });
    }
  }

  Future<void> _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('messages_${widget.userName}', jsonEncode(_messages));
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final timestamp = DateTime.now();
      setState(() {
        _messages.add({
          "type": "sent",
          "text": _controller.text,
          "timestamp": timestamp.toIso8601String()
        });
        _controller.clear();
      });
      await _saveMessages(); // Sử dụng await để chắc chắn dữ liệu đã được lưu
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 20,
              backgroundImage: AssetImage(widget.userImage),
            ),
            SizedBox(width: 10),
            Text(
              widget.userName,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showTime = index == 0 ||
                    (index > 0 &&
                        DateTime.parse(_messages[index - 1]['timestamp'])
                            .difference(DateTime.parse(message['timestamp']))
                            .inMinutes
                            .abs() >
                            1);
                return Column(
                  crossAxisAlignment: message['type'] == 'received'
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    if (showTime)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          DateFormat('HH:mm').format(DateTime.parse(message['timestamp'])),
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    message['type'] == 'received'
                        ? buildReceivedMessage(message['text'])
                        : buildSentMessage(message['text']),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0), // Thêm khoảng cách với viền dưới
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50, // Chiều cao của TextField
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15), // Giảm kích thước border
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                      style: TextStyle(fontSize: 16), // Giảm kích thước chữ trong TextField
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReceivedMessage(String message) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget buildSentMessage(String message) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
