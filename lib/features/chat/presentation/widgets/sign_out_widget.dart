import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_bloc.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_event.dart';
import 'package:flutter_chat/main_application_screen.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<SignInWithGoogleBloc>(context)..add(AppExit());
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
