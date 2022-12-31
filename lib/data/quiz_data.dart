import 'package:flutter/material.dart';

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
