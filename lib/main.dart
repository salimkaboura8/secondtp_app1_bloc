import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz Game',
      home: BlocProvider(
        create: (context) => QuizBloc(QuizState.initial()),
        child: QuizzPage(),
      ),
    );
  }
}

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

class QuizBloc extends Bloc<NextQuestion, QuizState> {
  QuizBloc(QuizState initialState) : super(initialState);

  QuizState get state => super.state;

  @override
  Stream<QuizState> mapEventToState(NextQuestion event) async* {
    final questions = state.questions;
    final answers = state.answers;
    final questionIndex = state.questionIndex;
    final score = state.score;

    if (questionIndex == questions.length - 1) {
      // Quiz is completed, emit final QuizState
      yield QuizState(questions, answers, questionIndex,
          event.userAnswer == answers[questionIndex] ? score + 1 : score);
    } else {
      // Quiz is not completed, move on to next question
      yield QuizState(questions, answers, questionIndex + 1,
          event.userAnswer == answers[questionIndex] ? score + 1 : score);
    }
  }
}

class QuizState {
  final List<String> questions;
  final List<bool> answers;
  final int questionIndex;
  final int score;

  QuizState(this.questions, this.answers, this.questionIndex, this.score);

  factory QuizState.initial() {
    return QuizState([
      'La France a dû céder l\'Alsace et la Moselle à l\'Allemagne après la guerre de 1870-1871?',
      'Le Mont Saint-Michel se trouve en Bretagne',
      'La Seine est le fleuve le plus long de France',
      'La France métropolitaine est entourée de trois mers',
      'Situé dans les Alpes, le mont Blanc est le plus haut sommet d’Europe.',
    ], [
      true,
      false,
      false,
      true,
      true,
    ], 0, 0);
  }

  String getQuestion() {
    return questions[questionIndex];
  }
}

class NextQuestion {
  final bool userAnswer;

  NextQuestion(this.userAnswer);
}
