import 'package:demo/screen/auth/login_screen.dart';
import 'package:demo/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/setting_widget.dart';
import 'account_screen.dart';
import 'change_password_screen.dart';
import 'information_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;
  bool isNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(249, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'SETTING',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildSettingSection(
              title: 'Account',
              children: [
                buildSettingItem('Information', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformationPage()),
                  );
                }),
                buildSettingItem('Change Password', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordPage()),
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            buildSettingSection(
              title: 'General',
              children: [
                buildSettingItem(
                  'Language',
                  trailing: const Text('English', style: TextStyle(color: Colors.black)),
                  onTap: () {},
                ),
                buildSettingItem(
                  'Dark Mode',
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (bool value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                  onTap: () {},
                ),
                buildSettingItem(
                  'Notification',
                  trailing: Switch(
                    value: isNotification,
                    onChanged: (bool value) {
                      setState(() {
                        isNotification = value;
                      });
                    },
                  ),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildSettingSection(
              title: 'About us',
              children: [
                buildSettingItem('Website', onTap: () {}),
                buildSettingItem('Help', onTap: () {}),
              ],
            ),
            const SizedBox(height: 20),
            buildSettingSection(
              title: 'Red Zone',
              children: [
                buildSettingItem(
                  'Log out',
                  trailing: const Icon(Icons.logout, color: Colors.black),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                    );
                  },
                ),
                buildSettingItem(
                  'Delete account',
                  textColor: Colors.red,
                  onTap: () {
                    showDeleteAccountDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white, // Đặt nền màu trắng
          title: const Center(
            child: Text(
              'Do you really want to delete your account?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle account deletion
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
