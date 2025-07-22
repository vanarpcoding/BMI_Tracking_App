import 'package:basic_flutter/projectlogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart'; // Import your UserProvider

class ResetPassword extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Warning'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.blue),
          ),
          Center(
            child: Container(
              width: size.width * 0.4,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final username = _usernameController.text;
                        final newPassword = _passwordController.text;

                        if (username.isEmpty || newPassword.isEmpty) {
                          _showAlertDialog(
                            context,
                            'Please fill in all the fields before proceeding.',
                          );
                        } else {
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);

                          userProvider.updatePassword(username, newPassword);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password updated successfully'),
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProjectLogin(),
                            ),
                          );
                        }
                      },
                      child: Text('Reset Password'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
