import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome back you\'ve\nbeen missed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(color: Colors.green[800]),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle sign in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                    },
                    child: const Text(
                      'Create new account',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('assets/google.png'),
                      iconSize: 40,
                      onPressed: () {
                        // Handle Google sign in
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/facebook.png'),
                      iconSize: 40,
                      onPressed: () {
                        // Handle Facebook sign in
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/apple.png'),
                      iconSize: 40,
                      onPressed: () {
                        // Handle Apple sign in
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
