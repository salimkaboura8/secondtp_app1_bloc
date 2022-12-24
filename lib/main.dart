import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp()); // point d'entrée

// Le widget racine de notre application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // une application utilisant Material Design
      title: 'My First Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity
              .adaptivePlatformDensity), // données relatives au thème choisi
      home: const ProfileHomePage(), //
      routes: {
        '/second': (context) => const QuizzPage(title: "Quizz"),
      }, // le widget de la page d'accueil
    );
  }
}

// Le widget de notre page d'accueil
class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Home Page"),
          centerTitle: false,
          //...
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 120),
                child: Stack(alignment: Alignment.center, children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 90),
                    child: SizedBox(
                      height: 180,
                      width: 280,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.pinkAccent,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Salim Kaboura',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'salim@email.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        'twitter: bogoss34',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(80),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  label: Text('Exercice 2'),
                  icon: Icon(Icons.arrow_forward_outlined),
                  backgroundColor: Colors.blueAccent,
                ),
              )
            ]),
          ),
        ));
  }

  //Container _getCard() {...}
  //Container _getAvatar() {...}
}

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quizz Page"),
          centerTitle: false,
        ),
        backgroundColor: Colors.blueGrey,
        body: Container());
  }

  @override
  State<QuizzPage> createState() => SomeQuizzPageState();
}

class Question {
  String questionText;
  bool isCorrect;
  Question({required this.questionText, required this.isCorrect});
}

class SomeQuizzPageState extends State<QuizzPage> {
  final List<Question> _questions = [
    Question(
        questionText:
            'La France a dû céder l\'Alsace et la Moselle à l\'Allemagne après la guerre de 1870-1871?',
        isCorrect: true),
    Question(
        questionText: 'Le Mont Saint-Michel se trouve en Bretagne',
        isCorrect: false),
    Question(
        questionText: 'La Seine est le fleuve le plus long de France',
        isCorrect: false),
    Question(
        questionText: ' La France métropolitaine est entourée de trois mers',
        isCorrect: true),
    Question(
        questionText:
            'Situé dans les Alpes, le mont Blanc est le plus haut sommet d’Europe.',
        isCorrect: true),
  ];
  int _questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizz Page"),
        centerTitle: false,
      ),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/france.jpg')),
            Container(
              margin: const EdgeInsets.all(40),
              child: Text(
                _questions[_questionIndex].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
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
                      _checkAnswer(true, context);
                    },
                    child: Text('Vrai'))),
            SizedBox(
                width: 160,
                child: ElevatedButton(
                    onPressed: () {
                      _checkAnswer(false, context);
                    },
                    child: Text('Faux')))
          ],
        ),
      ),
    );
  }

  void _checkAnswer(bool userChoice, BuildContext context) {
    if (userChoice == _questions[_questionIndex].isCorrect) {
      final snackbar = const SnackBar(
        content: Text('Bonne réponse!'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      _nextQuestion();
    } else {
      final snackbar = const SnackBar(
        content: Text('Fausse réponse!'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      _nextQuestion();
    }
  }

  void _nextQuestion() {
    setState(() {
      if (_questionIndex < 4) _questionIndex++;
    });
  }
}
