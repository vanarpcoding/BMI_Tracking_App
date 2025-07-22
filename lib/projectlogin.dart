import 'package:basic_flutter/bmipage.dart';
import 'package:basic_flutter/forgotpassword.dart';
import 'package:basic_flutter/functionfile.dart';
import 'package:basic_flutter/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart'; // Import your UserProvider

class ProjectLogin extends StatefulWidget {
  const ProjectLogin({super.key});

  @override
  State<ProjectLogin> createState() => _LoginPageState();
}

class _LoginPageState extends State<ProjectLogin> {
  bool isvisible = true;

  void updatevisibility() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgimagelogin.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Container(
              width: size.width * 0.2,
              height: 500,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Image.asset('assets/images/loginbmi.png'),
                  ),
                  Text("WELCOME",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordcontroller,
                      obscureText: isvisible,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            updatevisibility();
                          },
                          icon: Icon(isvisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          },
                          child: Text("Forgot Password?",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final username = usernamecontroller.text;
                        final password = passwordcontroller.text;
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);

                        final user = userProvider.users.firstWhere(
                          (user) =>
                              user.username == username &&
                              user.password == password,
                          orElse: () => User(username: '', password: ''),
                        );

                        if (user.username.isNotEmpty) {
                          storebooldata(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Project(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid username or password'),
                            ),
                          );
                        }
                      },
                      child: Text("   Login   ", style: TextStyle()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text("Dont have an account yet?"),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
                            },
                            child: Text("Sign Up")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
