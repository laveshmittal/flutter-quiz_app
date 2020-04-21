import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quizzler"),

        ),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 15.0),
              child: QuizPage(),
            ),),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  void addScore(int score){
    if(score==1){
      scoreKeeper.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    }
    else{
      scoreKeeper.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(quizBrain.getQuestionText()
                  ,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),),

              ),
            ),
          ),
          Expanded(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(

                padding: EdgeInsets.all(20.0),
                color: Colors.green,
                onPressed: (){
                  print("pressed");
                  setState(() {
                    if(quizBrain.getQuestionAnswer() == true){
                      addScore(1);
                    }
                    else{
                      addScore(0);
                    }

                    if(quizBrain.ifLast()){
                      Alert(
                        context: context,
                        title: "Quiz Completed",
                        desc: "You have completed the quiz",

                      ).show();
                      scoreKeeper = [];
                  }
                    else{
                      quizBrain.nextQuestion();
                    }
                  }
                      );
                },
                child: Text("True",
                style: TextStyle(
                  color: Colors.white,
                ),),
              ),
            ),
          ),
          Expanded(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(

                color: Colors.red,
                onPressed: () {
                  print("pressed");
                  setState(() {
                    if (quizBrain.getQuestionAnswer() == false) {
                      addScore(1);
                    }
                    else {
                      addScore(0);
                    }
                    if(quizBrain.ifLast()){
                      Alert(
                        context: context,
                        title: "Quiz Completed",
                        desc: "You have completed the quiz",

                      ).show();
                      scoreKeeper = [];
                    }
                    else{
                      quizBrain.nextQuestion();
                    }
                  });
                },
                child: Text("False",
                  style: TextStyle(
                    color: Colors.white,
                  ),),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: scoreKeeper,
            ),
          ),
        ],
      ),
    );
  }
}
