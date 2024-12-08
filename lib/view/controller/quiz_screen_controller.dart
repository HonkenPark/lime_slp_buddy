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

  final RxBool _toggleKoreanMeaning = false.obs;
  bool get toggleKoreanMeaning => _toggleKoreanMeaning.value;
  set toggleKoreanMeaning(bool value) => _toggleKoreanMeaning.value = value;

  Future<void> loadQuizData(String filePath) async {
    final String jsonString = await rootBundle.loadString(filePath);
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

  void checkAnswer(String userAnswer) {
    String correctAnswer = randomizedQuestions[currentQuestionIndex]['word'].toLowerCase();

    if (userAnswer == correctAnswer || userAnswer == 'skip') {
      player.play(AssetSource('audio/pass.mp3'));
      doumiState = DoumiState.correctanswer;
      currentQuestionIndex += 1;
    } else {
      player.play(AssetSource('audio/fail.mp3'));
      doumiState = DoumiState.wronganswer;
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

  String getNormalImagePath(int doumiIndex) {
    String path = '';
    if (doumiIndex == 1) {
      // Sizue
      path = 'assets/image/normal_sizue.png';
    } else if (doumiIndex == 2) {
      // June
      path = 'assets/image/normal_june.png';
    } else {
      // Mamekichi
      path = 'assets/image/normal_mamekichi.png';
    }
    return path;
  }

  String getWrongInputImagePath(int doumiIndex) {
    String path = '';
    if (doumiIndex == 1) {
      // Sizue
      path = 'assets/image/wroipt_sizue.png';
    } else if (doumiIndex == 2) {
      // June
      path = 'assets/image/wroipt_june.png';
    } else {
      // Mamekichi
      path = 'assets/image/wroipt_mamekichi.png';
    }
    return path;
  }

  String getWrongAnswerImagePath(int doumiIndex) {
    String path = '';
    if (doumiIndex == 1) {
      // Sizue
      path = 'assets/image/wroans_sizue.png';
    } else if (doumiIndex == 2) {
      // June
      path = 'assets/image/wroans_june.png';
    } else {
      // Mamekichi
      path = 'assets/image/wroans_mamekichi.png';
    }
    return path;
  }

  String getCorrectAnswerImagePath(int doumiIndex) {
    String path = '';
    if (doumiIndex == 1) {
      // Sizue
      path = 'assets/image/correct_sizue.png';
    } else if (doumiIndex == 2) {
      // June
      path = 'assets/image/correct_june.png';
    } else {
      // Mamekichi
      path = 'assets/image/correct_mamekichi.png';
    }
    return path;
  }
}
