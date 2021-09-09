import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/common/widgets/spinner.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/pages/home.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/pages/sign_in.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_event.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_state.dart';

import 'package:flutter_chat/locator_service.dart' as di;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.blue,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (context) => di.sl<UsersBloc>(),
        ),
        BlocProvider<SignInWithGoogleBloc>(
          create: (context) => di.sl<SignInWithGoogleBloc>()..add(AppStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: BlocBuilder<SignInWithGoogleBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Home();
            } else if (state is Unauthenticated) {
              return SignIn();
            } else {
              return Spinner();
            }
          },
        ),
      ),
    );
  }
}
