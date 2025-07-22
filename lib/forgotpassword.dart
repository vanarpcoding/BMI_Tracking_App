import 'dart:math';
import 'package:basic_flutter/resetpassword.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _phoneEmailController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  void _generateOTP() {
    final phoneEmail = _phoneEmailController.text;

    if (phoneEmail.isEmpty) {
      _showAlertDialog('Warning', 'Please enter your phone number or email.');
    } else {
      final otp = Random().nextInt(9000) + 1000; // Generate a 4-digit OTP
      final otpString = otp.toString();

      for (int i = 0; i < 4; i++) {
        _otpControllers[i].text = otpString[i];
      }
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
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

  void _handleSubmit() {
    final phoneEmail = _phoneEmailController.text;

    if (phoneEmail.isEmpty) {
      _showAlertDialog('Warning', 'Please enter your phone number or email.');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPassword()),
      );
    }
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
              height: 600,
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
                    SizedBox(
                      width: 300,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Image.asset('assets/images/forgotpassword.png'),
                      ),
                    ),
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _phoneEmailController,
                      decoration: InputDecoration(
                        labelText: 'Phone or Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _generateOTP,
                      child: Text('Generate OTP'),
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: SizedBox(
                            width: 40,
                            child: TextField(
                              controller: _otpControllers[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              readOnly: true, // Make the OTP fields read-only
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      child: Text('Submit'),
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
