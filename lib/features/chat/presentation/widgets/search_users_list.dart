import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/features/chat/presentation/widgets/search_list_user_tile.dart';

class SearchUsersListWidget extends StatelessWidget {
  final Stream<QuerySnapshot> usersStream;
  final String myUserName;
  const SearchUsersListWidget(
      {required this.myUserName, required this.usersStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return SearchListUserTileWidget(
                    profileUrl: ds['imgUrl'],
                    name: ds['name'],
                    username: ds['username'],
                    email: ds['email'],
                    myUserName: myUserName,
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
