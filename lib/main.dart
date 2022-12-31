import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tp2_app1/presentation/quiz_page.dart';

import 'data/quiz_data.dart';

void main() => runApp(MyApp()); // point d'entrée

// Le widget racine de notre application

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz Game',
      home: ChangeNotifierProvider(
        create: (context) => QuizData(),
        child: QuizzPage(),
      ),
    );
  }
}
