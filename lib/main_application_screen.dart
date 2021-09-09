import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/search_user_for_chat/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_chat/locator_service.dart';

class MainApplicationScreen extends StatelessWidget {
  const MainApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<UsersBloc>(
        create: (context) => sl<UsersBloc>(),
      ),
    ], child: Scaffold());
  }
}
