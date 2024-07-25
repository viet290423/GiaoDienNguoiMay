import 'package:demo/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/setting_widget.dart';
import 'account_screen.dart';

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
                buildSettingItem('Profile', onTap: () {}),
                buildSettingItem('Change Password', onTap: () {}),
              ],
            ),
            const SizedBox(height: 20),
            buildSettingSection(
              title: 'General',
              children: [
                buildSettingItem('Language', trailing: const Text('English'), onTap: () {}),
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
                buildSettingItem('Log out', trailing: const Icon(Icons.logout), onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }),
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
          title: const Center(
            child: Text(
              'Do you really want to delete your account?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
