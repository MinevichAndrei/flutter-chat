import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.error),
        const SizedBox(height: 15),
        Text(
          "Error",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
