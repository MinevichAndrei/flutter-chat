import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_room_messages_bloc/chat_room_messages_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/create_chat_bloc/create_chat_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_from_local_storage_bloc/user_from_local_storage_bloc.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:flutter_chat/features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_event.dart';
import 'package:flutter_chat/locator_service.dart' as di;
import 'package:flutter_chat/main_application_screen.dart';
import 'features/sign_in/presentation/bloc/sign_in_with_google/sign_in_with_google_bloc.dart';

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
        BlocProvider<SearchUserBloc>(
          create: (context) => di.sl<SearchUserBloc>(),
        ),
        BlocProvider<UserFromLocalStorageBloc>(
          create: (context) => di.sl<UserFromLocalStorageBloc>(),
        ),
        BlocProvider<SignInWithGoogleBloc>(
          create: (context) => di.sl<SignInWithGoogleBloc>()..add(AppStarted()),
        ),
        BlocProvider<UsersInfoBloc>(
          create: (context) => di.sl<UsersInfoBloc>(),
        ),
        BlocProvider<ChatsBloc>(create: (context) => di.sl<ChatsBloc>()),
        BlocProvider<CreateChatBloc>(
            create: (context) => di.sl<CreateChatBloc>()),
        BlocProvider<ChatRoomMessagesBloc>(
            create: (context) => di.sl<ChatRoomMessagesBloc>()),
        BlocProvider<SendMessageBloc>(
            create: (context) => di.sl<SendMessageBloc>()),
      ],
      child: MaterialApp(
          title: 'Flutter Chat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: MainApplicationScreen()),
    );
  }
}
