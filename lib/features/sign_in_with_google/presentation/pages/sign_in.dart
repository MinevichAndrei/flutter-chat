import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_event.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_state.dart';
import 'package:flutter_chat/main_application_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            )));

    final password = TextFormField(
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            )));

    return BlocBuilder<SignInWithGoogleBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: [
                  SizedBox(
                    height: 48.0,
                  ),
                  email,
                  SizedBox(
                    height: 8.0,
                  ),
                  password,
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 200.0, height: 42.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                              elevation:
                                  MaterialStateProperty.all<double>(5.0)),
                          child: Text(
                            'Log In',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          onPressed: () => {
                            context
                                .read<SignInWithGoogleBloc>()
                                .add(AppStarted()),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainApplicationScreen())),
                            //AuthMethods().signInWithGoogle(context)
                          },
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
