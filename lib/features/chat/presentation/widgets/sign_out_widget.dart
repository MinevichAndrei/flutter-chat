import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/auth_methods_bloc/auth_methods_bloc.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/auth_methods_bloc/auth_methods_event.dart';
import 'package:flutter_chat/main_application_screen.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AuthMethodsBloc>(context)..add(AppExitEvent());
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainApplicationScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
