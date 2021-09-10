import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_bloc.dart';
import 'package:flutter_chat/features/sign_in_with_google/presentation/bloc/sign_in_with_google_bloc/sign_in_with_google_event.dart';

import 'package:flutter_chat/locator_service.dart' as di;
import 'package:flutter_chat/main_application_screen.dart';

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
        BlocProvider<UsersInfoBloc>(
          create: (context) => di.sl<UsersInfoBloc>(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Chat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: MainApplicationScreen()),
    );
  }
}
