import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/widgets/app_bar_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarWidget(
        icon: CupertinoIcons.chat_bubble,
        title: "Messages",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2, // Số lượng tin nhắn
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                      ),
                      title: Text('Phúc Thành'),
                      subtitle: Text('Đi đâu đấy??'),
                      trailing: Text('17:35'),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
