import 'package:demo/screen/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 50), // Add some space at the top
                        Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6D9886),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Welcome back you\'ve\nbeen missed!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 70),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Phone number',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF2E7D5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                          ),
                        ),
                        SizedBox(height: 25),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF2E7D5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            child: Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: Color(0xFF6D9886),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            // Handle sign in
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            minimumSize: Size(double.infinity, 56),
                          ),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Handle create new account
                            },
                            child: Text(
                              'Create new account',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        Center(
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              color: Color(0xFF6D9886),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SocialMediaButton(
                              imagePath: 'assets/images/google.png',
                              onTap: () {
                                // Handle Google sign in
                              },
                            ),
                            SizedBox(width: 16), // Space between buttons
                            SocialMediaButton(
                              imagePath: 'assets/images/facebook.png',
                              onTap: () {
                                // Handle Facebook sign in
                              },
                            ),
                            SizedBox(width: 16), // Space between buttons
                            SocialMediaButton(
                              imagePath: 'assets/images/apple.png',
                              onTap: () {
                                // Handle Apple sign in
                              },
                            ),
                          ],
                        ),
                        Spacer(), // Fill remaining space
                        SizedBox(height: 30), // Add some space at the bottom
                      ],
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
          color: Color(0xFFEFEFEF),
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
