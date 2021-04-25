import 'package:dev_quiz/challenge/challenge_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "dev_quiz",
      home: ChallengePage(),
    );
  }
}
