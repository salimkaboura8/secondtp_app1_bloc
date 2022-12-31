import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/quiz_data.dart';
import '../main.dart';

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
