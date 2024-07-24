import 'package:demo/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'account_screen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'SETTING',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(  // Thêm SingleChildScrollView để có thể cuộn
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
            SizedBox(height: 20),
            buildSettingSection(
              title: 'General',
              children: [
                buildSettingItem('Language', trailing: Text('English'), onTap: () {}),
                buildSettingItem(
                  'Dark Mode',
                  trailing: Switch(value: false, onChanged: (bool value) {}),
                  onTap: () {},
                ),
                buildSettingItem(
                  'Notification',
                  trailing: Switch(value: false, onChanged: (bool value) {}),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            buildSettingSection(
              title: 'About us',
              children: [
                buildSettingItem('Website', onTap: () {}),
                buildSettingItem('Help', onTap: () {}),
              ],
            ),
            SizedBox(height: 20),
            buildSettingSection(
              title: 'Red Zone',
              children: [
                buildSettingItem('Log out', trailing: Icon(Icons.logout), onTap: () {}),
                buildSettingItem(
                  'Delete account',
                  textColor: Colors.red,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingSection({required String title, required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget buildSettingItem(String text, {Widget? trailing, Color textColor = Colors.black, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 18, color: textColor),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
