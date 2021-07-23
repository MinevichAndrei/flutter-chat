import 'package:flutter/material.dart';
import 'package:flutter_chat/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Chat"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            AuthMethods().signInWithGoogle(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffDB4437),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Sign In with Google",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
