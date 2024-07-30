import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/widgets/app_bar_widget.dart';
import 'chat_detail_screen.dart';
import 'ai_chat_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String lastMessageHoa = '';
  String lastMessagePhucThanh = '';

  @override
  void initState() {
    super.initState();
    _loadLastMessages();
  }

  Future<void> _loadLastMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesHoa = prefs.getString('messages_Hoa');
    String? messagesPhucThanh = prefs.getString('messages_Phuc Thành');

    if (messagesHoa != null) {
      List<dynamic> messagesList = jsonDecode(messagesHoa);
      if (messagesList.isNotEmpty) {
        setState(() {
          lastMessageHoa = messagesList.last['text'];
        });
      }
    }

    if (messagesPhucThanh != null) {
      List<dynamic> messagesList = jsonDecode(messagesPhucThanh);
      if (messagesList.isNotEmpty) {
        setState(() {
          lastMessagePhucThanh = messagesList.last['text'];
        });
      }
    }
  }

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
                prefixIcon: Icon(Icons.search, color: Colors.black,),
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
              itemCount: 3,
              itemBuilder: (context, index) {
                if (index == 2) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/chatbot_logo.png'),
                        ),
                        title: Text(
                          'AI Chat',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text('Start chatting with AI'),
                        trailing: Text(''),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AIChatDetailScreen(
                                userName: 'AI Chat',
                                userImage: 'assets/images/chatbot_logo.png',
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(),
                    ],
                  );
                } else if (index == 1) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/flowers.png'),
                        ),
                        title: Text(
                          'Hoa',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(lastMessageHoa.isNotEmpty ? lastMessageHoa : 'What your name'),
                        trailing: Text('16:20'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(
                                userName: 'Hoa',
                                userImage: 'assets/images/flowers.png',
                              ),
                            ),
                          ).then((_) {
                            _loadLastMessages(); // Load last messages again when returning from chat screen
                          });
                        },
                      ),
                      Divider(),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/labubu5.webp'),
                        ),
                        title: Text(
                          'Phúc Thành',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(lastMessagePhucThanh.isNotEmpty ? lastMessagePhucThanh : 'How can I help you today'),
                        trailing: Text('17:35'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(
                                userName: 'Phúc Thành',
                                userImage: 'assets/images/labubu5.webp',
                              ),
                            ),
                          ).then((_) {
                            _loadLastMessages(); // Load last messages again when returning from chat screen
                          });
                        },
                      ),
                      Divider(),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
