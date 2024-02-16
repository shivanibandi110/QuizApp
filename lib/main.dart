import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'answers': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctIndex': 0,
    },
    {
      'question': 'What is the national fruit of India ?',
      'answers': ['Apple', 'Mango', 'Banana', 'Kiwi'],
      'correctIndex': 1,
    },
    {
      'question': 'Is Flutter a Application development Language ?',
      'answers': ['Yes', 'Maybe', 'No', 'All the above'],
      'correctIndex': 2,
    },
    {
      'question': 'Who wrote "Romeo and Juliet"?',
      'answers': ['Shakespeare', 'Hemingway', 'Dickens', 'Twain'],
      'correctIndex': 0,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_questionIndex]['correctIndex']) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: _questionIndex < _questions.length
          ? QuizQuestion(
              question: _questions[_questionIndex]['question'],
              answers: _questions[_questionIndex]['answers'],
              answerHandler: _answerQuestion,
            )
          : QuizResult(
              score: _score,
              totalQuestions: _questions.length,
              resetHandler: _resetQuiz,
            ),
    );
  }
}

class QuizQuestion extends StatelessWidget {
  final String question;
  final List<String> answers;
  final Function(int) answerHandler;

  QuizQuestion({
    required this.question,
    required this.answers,
    required this.answerHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          question,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ...answers.asMap().entries.map((entry) {
          final index = entry.key;
          final answer = entry.value;
          return ElevatedButton(
            onPressed: () => answerHandler(index),
            child: Text(answer),
          );
        }).toList(),
      ],
    );
  }
}

class QuizResult extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback resetHandler;

  QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.resetHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Text(
            'Score: $score / $totalQuestions',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetHandler,
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
