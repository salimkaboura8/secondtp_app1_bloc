import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/quiz_bloc.dart';
import '../main.dart';

class QuizzPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Quizz Page"),
        centerTitle: false,
      ),
      backgroundColor: Colors.blueGrey,
      body: quizBloc.state.questionIndex <= quizBloc.state.questions.length - 1
          ? Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const Image(image: AssetImage('assets/images/france.jpg')),
                  Container(
                    margin: const EdgeInsets.all(40),
                    child: Text(
                      quizBloc.state.getQuestion(),
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
                            quizBloc.add(NextQuestion(true));
                          },
                          child: Text('Vrai'))),
                  SizedBox(
                      width: 160,
                      child: ElevatedButton(
                          onPressed: () {
                            quizBloc.add(NextQuestion(false));
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
                    'Votre score est ${quizBloc.state.score}/5',
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  )
                ],
              ),
            ),
    );
  }
}
