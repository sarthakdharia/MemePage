import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:html';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/memepage.dart';
import 'package:myapp/models/answer.dart';

class QuestionAnswerPage extends StatefulWidget {
  const QuestionAnswerPage({Key? key}) : super(key: key);

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  TextEditingController _questionFieldController = TextEditingController();

  Answer? _currentAnswer;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _handleGetAnswer() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://yesno.wtf/api'));
      if (response.statusCode == 200 && response.body != null) {
        Map<String, dynamic> resposeBody = json.decode(response.body);
        Answer answer = Answer.fromMap(resposeBody);
        setState(() {
          _currentAnswer = answer;
        });
      }
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Show Me',
          style: GoogleFonts.jost(),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Meme()),
                  );
                },
                child: Icon(
                  Icons.insert_photo_outlined,
                  size: 26.0,
                ),
              )),
        ],
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 0.5 * MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Ask ',
                  border: OutlineInputBorder(),
                ),
              )),
          SizedBox(height: 20),
          if (_currentAnswer != null)
            Stack(
              children: [
                Container(
                  height: 250,
                  width: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(_currentAnswer!.image)),
                  ),
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    _currentAnswer!.answer.toUpperCase(),
                    style: GoogleFonts.heebo(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ))
              ],
            ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: _handleGetAnswer,
                  child: Text('Search'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )))),
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {},
                  child: Text('Reset'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))))
            ],
          ),
        ],
      ),
    );
  }
}

class Meme extends StatefulWidget {
  const Meme({Key? key}) : super(key: key);

  @override
  State<Meme> createState() => _MemeState();
}

class _MemeState extends State<Meme> with SingleTickerProviderStateMixin {
  MemePage? _currentMeme;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _handleGetMeme() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://meme-api.herokuapp.com/gimme'));
      print(response);
      if (response.statusCode == 200 && response.body != null) {
        Map<String, dynamic> resposeBody = json.decode(response.body);
        MemePage title = MemePage.fromMap(resposeBody);
        setState(() {
          _currentMeme = title;
        });
      }
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meme Me',
          style: GoogleFonts.jost(),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuestionAnswerPage()),
                  );
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: _currentMeme != null
                          ? NetworkImage(_currentMeme!.url)
                          : NetworkImage(
                              'https://imgflip.com/s/meme/Blank-Nut-Button.jpg')),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: _handleGetMeme,
                  child: Text('Next'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))))
            ],
          ),
        ],
      ),
    );
  }
}
