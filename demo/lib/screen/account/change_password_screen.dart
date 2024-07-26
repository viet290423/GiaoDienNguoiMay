import 'package:demo/app/dimensions.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Hàm kiểm tra mật khẩu mới và mật khẩu xác nhận
  bool _isPasswordValid() {
    return _newPasswordController.text == _confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Old Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              controller: _oldPasswordController,
              decoration: InputDecoration(
                hintText: 'Enter old password',
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
            SizedBox(height: 20),
            Text(
              'New Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              controller: _newPasswordController,
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
            SizedBox(height: 20),
            Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm new password',
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
            SizedBox(height: Dimensions.height45),
            ElevatedButton(
              onPressed: () {
                if (_isPasswordValid()) {
                  // Xử lý logic thay đổi mật khẩu ở đây
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password changed successfully')),
                  );
                } else {
                  // Hiển thị thông báo lỗi nếu mật khẩu không khớp
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              child: Text('Change Password',
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255)),
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
    );
  }
}
