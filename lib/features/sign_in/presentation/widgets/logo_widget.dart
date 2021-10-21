import 'package:flutter/material.dart';
import 'package:flutter_chat/core/platform/screen_size.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: ScreenSize().width * 0.05, bottom: 30),
      child: Column(
        children: [
          Image.asset(
            'assets/images/splash.png',
            width: 100,
            height: 100,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Tiny Chat",
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
