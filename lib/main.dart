import 'dart:async';
import 'package:final_project/ScorePage.dart';
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
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: Colors.deepPurple,
          ),
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.deepPurple,
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          contentTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.deepPurple,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.deepPurpleAccent)
            .copyWith(
                primary: Colors.deepPurple, secondary: Colors.deepPurpleAccent),
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
  int currentQuestionIndex = 0;
  bool showCorrectAnswer = false;

  int score = 0;

  List<Question> questions = [
    Question(
      questionText: 'What is the largest animal on Earth?',
      options: ['Elephant', 'Giraffe', 'Blue Whale', 'Lion'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which animal is known as the "King of the Jungle"?',
      options: ['Lion', 'Tiger', 'Gorilla', 'Elephant'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'What do you call a baby kangaroo?',
      options: ['Calf', 'Puppy', 'Joey', 'Cub'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'How many legs does a spider have?',
      options: ['4', '6', '8', '10'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'What is the fastest land animal?',
      options: ['Cheetah', 'Lion', 'Gazelle', 'Tiger'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'Which animal can sleep for almost 22 hours a day?',
      options: ['Koala', 'Sloth', 'Panda', 'Hedgehog'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What is the largest species of penguin?',
      options: [
        'Emperor Penguin',
        'King Penguin',
        'Adélie Penguin',
        'Galápagos Penguin'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'Which animal is known as the "Ship of the Desert"?',
      options: ['Camel', 'Elephant', 'Giraffe', 'Llama'],
      correctAnswerIndex: 0,
    ),
    // Add more questions here
  ];

  void checkAnswer(int selectedOptionIndex) {
    setState(() {
      showCorrectAnswer = true;
    });

    if (selectedOptionIndex ==
        questions[currentQuestionIndex].correctAnswerIndex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Correct!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        ),
      );
      score++; // Increment the score if the answer is correct
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Incorrect! The correct answer is: ${questions[currentQuestionIndex].options[questions[currentQuestionIndex].correctAnswerIndex]}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }

    Future.delayed(const Duration(seconds: 1), () {
      goToNextQuestion();
    });
  }

  void goToNextQuestion() {
    setState(() {
      showCorrectAnswer = false;
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        navigateToScorePage(); // All questions answered, navigate to score page
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      // Delay the transition to the next question by 1 second
      setState(() {});
    });
  }

  void navigateToScorePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: score,
          totalQuestions: questions.length,
          restartQuiz: restartQuiz, // Pass the restartQuiz method to ScorePage
        ),
      ),
    );
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      showCorrectAnswer = false;
      score = 0;
    });
    Navigator.pop(context); // Navigate back to the first question
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex].questionText,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions[currentQuestionIndex].options.length,
                itemBuilder: (context, index) {
                  return OptionButton(
                    optionIndex: index,
                    optionText: questions[currentQuestionIndex].options[index],
                    onTap: checkAnswer,
                    showCorrectAnswer: showCorrectAnswer,
                    correctAnswerIndex:
                        questions[currentQuestionIndex].correctAnswerIndex,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: goToNextQuestion,
              child: Text(
                currentQuestionIndex < questions.length - 1 ? 'Next' : 'Finish',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final int optionIndex;
  final String optionText;
  final Function(int) onTap;
  final bool showCorrectAnswer;
  final int correctAnswerIndex;

  OptionButton({
    required this.optionIndex,
    required this.optionText,
    required this.onTap,
    required this.showCorrectAnswer,
    required this.correctAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    final color = showCorrectAnswer
        ? optionIndex == correctAnswerIndex
            ? Colors.green
            : Colors.red
        : Theme.of(context).colorScheme.secondary;

    return GestureDetector(
      onTap: () => showCorrectAnswer ? null : onTap(optionIndex),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(12.0),
        child: Text(
          optionText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}
