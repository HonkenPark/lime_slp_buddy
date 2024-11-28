import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:lime_slp_buddy/view/home_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  Get.put(const HomeScreen());

  runApp(const QuizApp());
}

enum QuizFileList {
  // notSelected('', ''),
  unit04_1120('유닛4 11번-20번', 'assets/json/Unit04_11_20.json'),
  unit04_2130('유닛4 21번-30번', 'assets/json/Unit04_21_30.json'),
  unit05_0110('유닛5 1번-10번', 'assets/json/Unit05_01_10.json'),
  unit05_1120('유닛5 11번-20번', 'assets/json/Unit05_11_20.json'),
  unit05_2130('유닛5 21번-30번', 'assets/json/Unit05_21_30.json');

  const QuizFileList(
    this.label,
    this.path,
  );
  final String label;
  final String path;
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
      home: ResponsiveBreakpoints.builder(
        child: const HomeScreen(),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
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
