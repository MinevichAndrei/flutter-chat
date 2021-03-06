import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/platform/screen_size.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/auth_methods_bloc/auth_methods_bloc.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/auth_methods_bloc/auth_methods_event.dart';
import 'package:flutter_chat/features/sign_in/presentation/pages/sign_in.dart';
import 'package:flutter_chat/features/sign_in/presentation/widgets/logo_widget.dart';
import 'package:flutter_chat/main_application_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late bool _passwordVisible;
  final _formKey = GlobalKey<FormState>();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: ScreenSize().height,
            width: ScreenSize().width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.blueAccent,
                ],
              ),
            ),
            child: Column(
              children: [
                LogoWidget(),
                Center(
                  child: Container(
                    height: ScreenSize().height * 0.18,
                    width: ScreenSize().width * 0.28,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              '??????????????????????',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocus,
                              autofocus: true,
                              onFieldSubmitted: (_) {
                                _fieldFocusChange(
                                    context, _emailFocus, _passwordFocus);
                              },
                              validator: (val) => _validateEmail(val!),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'E-mail',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              focusNode: _passwordFocus,
                              decoration: InputDecoration(
                                hintText: '????????????',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 15)),
                                  onPressed: () {
                                    _createUser();
                                  },
                                  child: Text('????????????????????????????????????'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  String? _validateEmail(String value) {
    final _emailExp = RegExp(r'/.+@.+\..+/i');
    if (value.isEmpty) {
      return '???????? E-mail ???? ?????????? ???????? ????????????';
    } else if (_emailExp.hasMatch(value)) {
      return '?????????????? ???????????????????? E-mail';
    } else {
      return null;
    }
  }

  void _createUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthMethodsBloc>().add(SignUpEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    }
  }
}
