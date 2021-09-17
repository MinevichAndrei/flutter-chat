import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/presentation/pages/home.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_bloc.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_state.dart';
import 'package:flutter_chat/features/sign_in/presentation/pages/sign_in.dart';

class MainApplicationScreen extends StatelessWidget {
  const MainApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInWithGoogleBloc, SignInWithGoogleState>(
      builder: (context, state) {
        if (state is SignInWithGoogleStateSuccess) {
          return Home();
        } else if (state is SignOuted) {
          return SignIn();
        } else {
          return Spinner();
        }
      },
    );
  }
}
