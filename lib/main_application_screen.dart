import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_state.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/pages/sign_in.dart';

import 'features/search_user_for_chat/presentation/pages/home.dart';
import 'features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_bloc.dart';

class MainApplicationScreen extends StatelessWidget {
  const MainApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInWithGoogleBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
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
