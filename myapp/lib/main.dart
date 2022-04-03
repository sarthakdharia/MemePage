import 'package:flutter/material.dart';
import 'package:myapp/pages/question_answer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aws demo Application',
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 119, 119, 119),
          primarySwatch: Colors.teal),
      home: QuestionAnswerPage(),
    );
  }
}
