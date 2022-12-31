import 'package:flutter/material.dart';

class QuizData with ChangeNotifier {
  int questionIndex = 0;
  int _score = 0;
  final List<String> questions = [
    'La France a dû céder l\'Alsace et la Moselle à l\'Allemagne après la guerre de 1870-1871?',
    'Le Mont Saint-Michel se trouve en Bretagne',
    'La Seine est le fleuve le plus long de France',
    'La France métropolitaine est entourée de trois mers',
    'Situé dans les Alpes, le mont Blanc est le plus haut sommet d’Europe.',
  ];
  final List<bool> _answers = [
    true,
    false,
    false,
    true,
    true,
  ];

  int getScore() {
    return _score;
  }

  String getQuestion() {
    return questions[questionIndex];
  }

  void nextQuestion(bool userAnswer) {
    _score = userAnswer == _answers[questionIndex] ? _score + 1 : _score;
    if (questionIndex < questions.length - 1) {
      questionIndex++;
    }
    notifyListeners();
  }
}
