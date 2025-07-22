// ignore_for_file: prefer_const_constructors

import 'package:basic_flutter/projectlogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart'; // Import your UserProvider

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isVisible = true;

  void updateVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _signUp() {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String city = _cityController.text;
    final String country = _countryController.text;
    final String phone = _phoneController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String rePassword = _rePasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        city.isEmpty ||
        country.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        rePassword.isEmpty) {
      _showAlertDialog('Please fill in all fields');
    } else if (password != rePassword) {
      _showAlertDialog('Passwords do not match');
    } else {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.addUser(email, password); // Use email as username
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProjectLogin(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CREATE NEW ACCOUNT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Image.network(
              "https://tse1.mm.bing.net/th?id=OIP._x2YqKMtfxOjkfT8g9xIvQHaG5&pid=Api&P=0&h=180",
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              labelText: "City",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: _countryController,
                            decoration: InputDecoration(
                              labelText: "Country",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email or Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _rePasswordController,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                        labelText: "Re-enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                          onPressed: updateVisibility,
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextButton(
                          onPressed: _signUp,
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
