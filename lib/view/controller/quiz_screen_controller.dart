import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lime_slp_buddy/main.dart';

class QuizScreenController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  final player = AudioPlayer();

  final RxInt _currentQuestionIndex = 0.obs;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  set currentQuestionIndex(int value) => _currentQuestionIndex.value = value;

  final RxList<Map<String, dynamic>> _quizData = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get quizData => _quizData;
  set quizData(List<Map<String, dynamic>> value) => _quizData.value = value;

  final RxList<Map<String, dynamic>> _randomizedQuestions = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get randomizedQuestions => _randomizedQuestions;
  set randomizedQuestions(List<Map<String, dynamic>> value) => _randomizedQuestions.value = value;

  final Rx<DoumiState> _doumiState = DoumiState.values.first.obs;
  DoumiState get doumiState => _doumiState.value;
  set doumiState(DoumiState value) => _doumiState.value = value;

  Future<void> loadQuizData() async {
    final String jsonString = await rootBundle.loadString('assets/json/page_11.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    quizData = jsonData.map((e) => e as Map<String, dynamic>).toList();
    randomizedQuestions = List.from(quizData)..shuffle(Random());
  }

  Future<void> liveChecking(String userInput) async {
    String correctAnswer = randomizedQuestions[currentQuestionIndex]['word'].toLowerCase();

    if (correctAnswer.startsWith(userInput) || userInput == correctAnswer) {
      doumiState = DoumiState.normal;
    } else {
      doumiState = DoumiState.wronginput;
    }
  }

  Future<void> checkAnswer(String userAnswer) async {
    String correctAnswer = randomizedQuestions[currentQuestionIndex]['word'].toLowerCase();

    if (userAnswer == correctAnswer) {
      doumiState = DoumiState.correctanswer;
      await player.play(AssetSource('audio/pass.mp3'));
      currentQuestionIndex += 1;
    } else {
      doumiState = DoumiState.wronganswer;
      await player.play(AssetSource('audio/fail.mp3'));
    }
  }

  String getImagePath(int doumiIndex) {
    String path = '';
    if (doumiIndex == 1) {
      // June
      if (doumiState == DoumiState.wronginput) {
        path = 'assets/image/wroipt_sizue.png';
      } else if (doumiState == DoumiState.wronganswer) {
        path = 'assets/image/wroans_sizue.png';
      } else if (doumiState == DoumiState.correctanswer) {
        path = 'assets/image/correct_sizue.png';
      } else {
        path = 'assets/image/normal_sizue.png';
      }
    } else if (doumiIndex == 2) {
      // Size
      if (doumiState == DoumiState.wronginput) {
        path = 'assets/image/wroipt_june.png';
      } else if (doumiState == DoumiState.wronganswer) {
        path = 'assets/image/wroans_june.png';
      } else if (doumiState == DoumiState.correctanswer) {
        path = 'assets/image/correct_june.png';
      } else {
        path = 'assets/image/normal_june.png';
      }
    } else {
      // Mamekichi
      if (doumiState == DoumiState.wronginput) {
        path = 'assets/image/wroipt_mamekichi.png';
      } else if (doumiState == DoumiState.wronganswer) {
        path = 'assets/image/wroans_mamekichi.png';
      } else if (doumiState == DoumiState.correctanswer) {
        path = 'assets/image/correct_mamekichi.png';
      } else {
        path = 'assets/image/normal_mamekichi.png';
      }
    }
    return path;
  }
}
