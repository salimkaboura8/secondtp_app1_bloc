import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp2_app1/presentation/quiz_page.dart';

import 'business_logic/quiz_bloc.dart';
import 'data/quiz_data.dart';

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

class NextQuestion {
  final bool userAnswer;

  NextQuestion(this.userAnswer);
}
