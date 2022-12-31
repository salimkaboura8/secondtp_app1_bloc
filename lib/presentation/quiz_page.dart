import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/quiz_data.dart';

class QuizzPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizData = Provider.of<QuizData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Quizz Page"),
        centerTitle: false,
      ),
      backgroundColor: Colors.blueGrey,
      body: quizData.questionIndex < quizData.questions.length - 1
          ? Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const Image(image: AssetImage('assets/images/france.jpg')),
                  Container(
                    margin: const EdgeInsets.all(40),
                    child: Text(
                      quizData.getQuestion(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 160,
                      child: ElevatedButton(
                          onPressed: () {
                            Provider.of<QuizData>(context, listen: false)
                                .nextQuestion(true);
                          },
                          child: Text('Vrai'))),
                  SizedBox(
                      width: 160,
                      child: ElevatedButton(
                          onPressed: () {
                            Provider.of<QuizData>(context, listen: false)
                                .nextQuestion(false);
                          },
                          child: Text('Faux')))
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Terminé!',
                    style: TextStyle(fontSize: 40.0, color: Colors.white),
                  ),
                  Text(
                    'Votre score est ${quizData.getScore()}/5',
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  )
                ],
              ),
            ),
    );
  }
}
