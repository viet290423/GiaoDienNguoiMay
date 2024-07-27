import 'package:demo/app/dimensions.dart';
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
      _phoneNumberController.text =
          prefs.getString('phone_number') ?? '0123456789';
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
        title: const Text(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Căn chỉnh tất cả các phần tử con về phía bên trái
            children: <Widget>[
              // Căn giữa ảnh tròn
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 150, // Kích thước lớn hơn cho ảnh tròn
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/labubu.webp'), // Thay đổi đường dẫn ảnh
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Username',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _usernameController,
                readOnly: !_isEditing, // Chỉ đọc khi không chỉnh sửa
                decoration: InputDecoration(
                  hintText: 'Enter new password',
                  hintStyle: const TextStyle(
                    fontFamily: 'Montserrat',
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
              const SizedBox(height: 20),
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneNumberController,
                readOnly: !_isEditing, // Chỉ đọc khi không chỉnh sửa
                decoration: InputDecoration(
                  hintText: 'Enter new password',
                  hintStyle: const TextStyle(
                    fontFamily: 'Montserrat',
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
              SizedBox(height: Dimensions.height30),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (_isEditing) {
                      // Lưu thay đổi
                      _saveData();
                    }
                    _isEditing = !_isEditing; // Chuyển trạng thái chỉnh sửa
                  });
                },
                icon: Icon(
                  _isEditing ? Icons.save : Icons.edit,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text(
                  _isEditing ? 'Save' : 'Edit',
                  style: TextStyle(
                      fontSize: Dimensions.font20 - 2,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
