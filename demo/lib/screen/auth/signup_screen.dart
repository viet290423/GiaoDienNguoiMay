import 'package:demo/screen/auth/login_screen.dart';
import 'package:demo/screen/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? phoneNumber;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 50),
                          const Text(
                            'Create Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6D9886),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'Create an account so you can explore all the existing jobs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
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
                                  vertical: 18.0, horizontal: 18.0),
                            ),
                            onChanged: (value) {
                              setState(() {
                                username = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please input your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
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
                                  vertical: 18.0, horizontal: 18.0),
                            ),
                            onChanged: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please input your phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
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
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please input your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
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
                            onChanged: (value) {
                              setState(() {
                                confirmPassword = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != password) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 35),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('username', username!);
                                await prefs.setBool(
                                    'isNewUser', true); // Lưu cờ đăng ký

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              minimumSize: const Size(double.infinity, 56),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: const Text(
                                'Already have an account',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          const Center(
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                color: Color(0xFF6D9886),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SocialMediaButton(
                                imagePath: 'assets/images/google.png',
                                onTap: () {
                                  // Handle Google sign in
                                },
                              ),
                              const SizedBox(
                                  width: 16), // Space between buttons
                              SocialMediaButton(
                                imagePath: 'assets/images/facebook.png',
                                onTap: () {
                                  // Handle Facebook sign in
                                },
                              ),
                              const SizedBox(
                                  width: 16), // Space between buttons
                              SocialMediaButton(
                                imagePath: 'assets/images/apple.png',
                                onTap: () {
                                  // Handle Apple sign in
                                },
                              ),
                            ],
                          ),
                          const Spacer(), // Fill remaining space
                          const SizedBox(
                              height: 30), // Add some space at the bottom
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const SocialMediaButton({required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60, // Adjust width as needed
        height: 44, // Adjust height as needed
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            width: 24, // Adjust icon size as needed
            height: 24, // Adjust icon size as needed
          ),
        ),
      ),
    );
  }
}
