import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:lime_slp_buddy/view/home_screen.dart';

void main() {
  Get.put(const HomeScreen());

  runApp(const QuizApp());
}

enum DoumiState {
  normal('0', 'assets/image/normal.png'),
  wronginput('1', 'assets/image/wrong_input.png'),
  wronganswer('2', 'assets/image/wrong_answer.png'),
  correctanswer('3', 'assets/image/correct_answer.png');

  const DoumiState(
    this.code,
    this.path,
  );
  final String code;
  final String path;
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      title: '라임이의 SLP 퀴즈 도우미',
      home: const HomeScreen(),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  List<Map<String, dynamic>> quizData = [];
  List<Map<String, dynamic>> randomizedQuestions = [];
  int currentQuestionIndex = 0;
  bool isQuizStarted = false;
  final TextEditingController answerController = TextEditingController();
  final AudioPlayer audioPlayer = AudioPlayer();
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    loadQuizData();
  }

  Future<void> loadQuizData() async {
    final String jsonString = await rootBundle.loadString('assets/json/241127_word_test.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    setState(() {
      quizData = jsonData.map((e) => e as Map<String, dynamic>).toList();
      randomizedQuestions = List.from(quizData)..shuffle(Random());
    });
    print('quiz size: ${quizData.length}');
  }

  void startQuiz() {
    setState(() {
      isQuizStarted = true;
      currentQuestionIndex = 0;
    });
  }

  Future<void> checkAnswer() async {
    String userAnswer = answerController.text.trim().toLowerCase();
    String correctAnswer = randomizedQuestions[currentQuestionIndex]['word'].toLowerCase();

    if (userAnswer == correctAnswer) {
      await player.play(AssetSource('audio/pass.mp3'));
      setState(() {
        currentQuestionIndex++;
      });
      answerController.clear();
    } else {
      await player.play(AssetSource('audio/fail.mp3'));
    }
  }

  Future<void> playAudio(String path) async {
    await audioPlayer.play(AssetSource(path));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildQuizContent(),
    );
  }

  Widget buildQuizContent() {
    if (currentQuestionIndex >= randomizedQuestions.length) {
      return const Text(
        '퀴즈 완료! 축하합니다!',
        style: TextStyle(fontSize: 24),
      );
    }

    Map<String, dynamic> currentQuestion = randomizedQuestions[currentQuestionIndex];
    List<dynamic> descriptions = currentQuestion['descriptions'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var description in descriptions)
          Column(
            children: [
              Text('의미 (한국어): ${description['meaning_k']}'),
              Text('의미 (영어): ${description['meaning_e']}'),
              Text('예문: ${description['sentence']}'),
              const SizedBox(height: 10),
            ],
          ),
        TextField(
          controller: answerController,
          decoration: const InputDecoration(labelText: '정답 입력'),
          onSubmitted: (_) => checkAnswer(),
        ),
        ElevatedButton(
          onPressed: checkAnswer,
          child: const Text('정답 확인'),
        ),
      ],
    );
  }
}
