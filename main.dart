import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizBrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/foot.jpeg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();

  var userAnswer = '';
  var level = '1';
  var score = 0;
  var iconCheck = Icon(
    Icons.check,
    color: Colors.green,
  );
  var iconClose = Icon(
    Icons.close,
    color: Colors.red,
  );

  var nextNumber = 0;
  List<Icon> scoreKeeper = [];
  iconMaker() {
    if (scoreKeeper.length < quizBrain.questionDic_1.length) {
      if (userAnswer == quizBrain.questionDic_1.values.elementAt(nextNumber)) {
        scoreKeeper.add(iconCheck);
        nextNumber++;
        score++;
      } else {
        scoreKeeper.add(iconClose);
        nextNumber++;
      }
    }
    if (scoreKeeper.length == quizBrain.questionDic_1.length) {
      onAlertButtonsPressed(context);
    }
  }

  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );
  reset() {
    scoreKeeper.clear();
    print(scoreKeeper.length);
    nextNumber = 0;
    userAnswer = '';
    score = 0;
  }

  onAlertButtonsPressed(context) {
    Alert(
      style: alertStyle,
      context: context,
      type: AlertType.success,
      title: "$score op ${quizBrain.questionDic_1.length}\nGoed gedaan ",
      desc: "wil je nog een keer spelen?",
      buttons: [
        DialogButton(
          child: Text(
            "JA",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            reset();
            Navigator.of(context).pop();
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(25, 131, 29, 1.0),
            Color.fromRGBO(2, 0, 36, 1.0),
          ]),
        ),
        DialogButton(
          child: Text(
            "NEE",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => exit(0),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(2, 0, 36, 1.0),
            Color.fromRGBO(162, 9, 33, 1.0),
          ]),
        )
      ],
    ).show();
  }

  questionNumber() {
    if (quizBrain.questionDic_1.length > nextNumber) {
      return Text(
        quizBrain.questionDic_1.keys.elementAt(nextNumber),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      scoreKeeper.clear();
      return Text(
        quizBrain.questionDic_1.keys.elementAt(0),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  levelUp() {
    setState(() {
      level = '1';
    });
  }

  onPressed() {
    onAlertButtonsPressed(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0))
              ],
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                  colors: [Colors.black, Colors.greenAccent])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.navigate_before,
                  color: Colors.yellow,
                ),
              ),
              Text(
                'Quiz',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.yellow,
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.navigate_next,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
            child: Center(
              child: questionNumber(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'Waar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                if (quizBrain.questionDic_1.length > nextNumber) {
                  setState(() {
                    userAnswer = 'True';

                    iconMaker();
                  });
                } else {
                  null;
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'Niet waar',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (quizBrain.questionDic_1.length > nextNumber) {
                  setState(() {
                    userAnswer = 'False';
                    iconMaker();
                  });
                } else {
                  null;
                }
                //The user picked false.
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.fromLTRB(5.0, 3, 5.0, 1.0),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0))
              ],
              borderRadius: BorderRadius.circular(10.0),
              gradient:
                  const LinearGradient(colors: [Colors.black, Colors.green])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
