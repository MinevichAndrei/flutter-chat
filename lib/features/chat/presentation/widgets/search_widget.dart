import 'package:flutter/material.dart';
import 'package:flutter_chat/features/chat/presentation/pages/search_screen.dart';

class SearchWidget extends StatelessWidget {
  final String username;
  const SearchWidget({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(myUserName: username),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.search),
      ),
    );
  }
}
