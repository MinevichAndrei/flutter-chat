import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/chat/presentation/pages/home.dart';
import 'package:flutter_chat/features/sign_in/presentation/pages/sign_in.dart';

import 'features/sign_in/presentation/bloc/auth_methods_bloc/auth_methods_bloc.dart';
import 'features/sign_in/presentation/bloc/auth_methods_bloc/auth_methods_state.dart';

class MainApplicationScreen extends StatelessWidget {
  const MainApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthMethodsBloc, AuthMethodsState>(
      builder: (context, state) {
        print(state);
        if (state is AuthentificatedState) {
          if (state.isAuth) {
            return Home();
          } else {
            return SignIn();
          }
        } else if (state is SignOuted) {
          return SignIn();
        } else if (state is AuthStateError) {
          return SignIn();
        } else {
          return Text('d,ofmorfkrof');
        }
      },
    );
  }
}
