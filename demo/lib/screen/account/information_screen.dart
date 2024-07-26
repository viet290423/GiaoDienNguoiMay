import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isEditing = false; // Trạng thái chỉnh sửa

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Tải dữ liệu từ SharedPreferences
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? 'pth.huy';
      _phoneNumberController.text = prefs.getString('phone_number') ?? '0123456789';
    });
  }

  // Lưu dữ liệu vào SharedPreferences
  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    prefs.setString('phone_number', _phoneNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Information',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white, // Đặt màu nền của AppBar là trắng
        foregroundColor: Colors.black, // Đặt màu chữ của AppBar là đen
      ),
      backgroundColor: Colors.white, // Đặt màu nền của Scaffold là trắng
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh tất cả các phần tử con về phía bên trái
          children: <Widget>[
            // Căn giữa ảnh tròn
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 150, // Kích thước lớn hơn cho ảnh tròn
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/labubu.webp'), // Thay đổi đường dẫn ảnh
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _usernameController,
                readOnly: !_isEditing, // Chỉ đọc khi không chỉnh sửa
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Bo góc tròn cho khung nhập liệu
                  ),
                  hintText: 'Enter username',
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _phoneNumberController,
                readOnly: !_isEditing, // Chỉ đọc khi không chỉnh sửa
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Bo góc tròn cho khung nhập liệu
                  ),
                  hintText: 'Enter phone number',
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (_isEditing) {
                      // Lưu thay đổi
                      _saveData();
                    }
                    _isEditing = !_isEditing; // Chuyển trạng thái chỉnh sửa
                  });
                },
                icon: Icon(_isEditing ? Icons.save : Icons.edit),
                label: Text(_isEditing ? 'Save' : 'Edit'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black, // Màu nền của nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bo góc tròn cho nút bấm
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
