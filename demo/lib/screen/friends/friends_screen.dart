import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<Friend> friends = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    final prefs = await SharedPreferences.getInstance();
    final String? temporaryFriendsJson = prefs.getString('temporary_friends');

    if (temporaryFriendsJson != null && temporaryFriendsJson.isNotEmpty) {
      // Phục hồi danh sách bạn bè đã thay đổi tạm thời
      final List<dynamic> friendsList = jsonDecode(temporaryFriendsJson);
      setState(() {
        friends = friendsList.map((data) => Friend.fromJson(data)).toList();
      });
    } else {
      // Thiết lập dữ liệu mặc định
      setState(() {
        friends = [
          Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu1.webp'),
          Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu2.webp'),
          Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu4.webp'),
          Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu5.webp'),
          Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu6.webp'),
          Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu.webp'),
          Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu1.webp'),
          Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu2.webp'),
          Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu4.webp'),
          Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu5.webp'),
          Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu6.webp'),
          Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu.webp'),
        ];
      });
      // Lưu danh sách bạn bè mặc định vào SharedPreferences
      _saveFriends(); // Đảm bảo rằng phương thức này lưu danh sách bạn bè vào SharedPreferences
    }
  }

  Future<void> _saveFriends() async {
    final prefs = await SharedPreferences.getInstance();
    final String friendsJson = jsonEncode(friends.map((friend) => friend.toJson()).toList());
    await prefs.setString('temporary_friends', friendsJson);
  }

  Future<void> _saveInitialFriends() async {
    final prefs = await SharedPreferences.getInstance();
    final String initialFriendsJson = jsonEncode([
      Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu1.webp'),
      Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu2.webp'),
      Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu4.webp'),
      Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu5.webp'),
      Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu6.webp'),
      Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu.webp'),
      Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu1.webp'),
      Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu2.webp'),
      Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu4.webp'),
      Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu5.webp'),
      Friend(name: 'John Doe', status: 'Online', profilePictureUrl: 'assets/images/labubu6.webp'),
      Friend(name: 'Jane Smith', status: 'Offline', profilePictureUrl: 'assets/images/labubu.webp'),
    ].map((friend) => friend.toJson()).toList());
    await prefs.setString('initial_friends', initialFriendsJson);
  }

  Future<void> _saveTemporaryFriends() async {
    final prefs = await SharedPreferences.getInstance();
    final String temporaryFriendsJson = jsonEncode(friends.map((friend) => friend.toJson()).toList());
    await prefs.setString('temporary_friends', temporaryFriendsJson);
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Deletion',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Text('Are you sure you want to delete this friend?'),
          backgroundColor: Colors.white, // Nền trắng cho hộp thoại
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white, // Chữ đen
                side: BorderSide(color: Colors.black), // Viền đen
              ),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Xóa bạn bè khỏi danh sách hiện tại
                  friends.removeAt(index);
                  _saveTemporaryFriends(); // Lưu danh sách xóa tạm thời
                });
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Chữ trắng
              ),
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Friends',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white, // Nền trắng cho AppBar
        elevation: 0, // Bỏ bóng dưới AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black), // Biểu tượng màu đen
            onPressed: () {
              // Logic to add friends
            },
          ),
        ],
      ),
      backgroundColor: Colors.white, // Nền trắng cho Scaffold
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white, // Nền trắng cho từng mục
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Đổ bóng nhẹ
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(friend.profilePictureUrl), // Sử dụng AssetImage
              ),
              title: Text(
                friend.name,
                style: TextStyle(color: Colors.black), // Màu chữ đen
              ),
              subtitle: Text(
                friend.status,
                style: TextStyle(color: Colors.grey[600]), // Màu chữ phụ
              ),
              trailing: IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Icon(Icons.close, color: Colors.white), // Biểu tượng dấu x màu trắng trong vòng tròn đen
                ),
                onPressed: () {
                  _showDeleteConfirmationDialog(index); // Hiển thị hộp thoại xác nhận xoá
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Mock data
class Friend {
  final String name;
  final String status;
  final String profilePictureUrl;

  Friend({
    required this.name,
    required this.status,
    required this.profilePictureUrl,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'status': status,
    'profilePictureUrl': profilePictureUrl,
  };

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    name: json['name'],
    status: json['status'],
    profilePictureUrl: json['profilePictureUrl'],
  );
}
