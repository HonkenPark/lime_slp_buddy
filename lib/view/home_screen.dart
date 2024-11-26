import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lime_slp_buddy/main.dart';
import 'package:lime_slp_buddy/view/controller/home_screen_controller.dart';
import 'package:lime_slp_buddy/view/controller/quiz_screen_controller.dart';
import 'package:lime_slp_buddy/view/quiz_screen.dart';
import "package:universal_html/html.dart" as html;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController homeScreenController = Get.put(HomeScreenController());
    final QuizScreenController quizScreenController = Get.put(QuizScreenController());
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                AppBar(
                  title: homeScreenController.quizStarted
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () async {
                                bool isOk = html.window.confirm('처음 화면으로 되돌아갈까요?');
                                if (isOk) {
                                  homeScreenController.quizStarted = false;
                                  homeScreenController.selectedDoumiIndex = 0;
                                  quizScreenController.currentQuestionIndex = 0;
                                  quizScreenController.doumiState = DoumiState.normal;
                                }
                              },
                              iconSize: 58.0,
                              color: Colors.pink,
                              icon: const Icon(
                                Icons.home,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 300,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage('assets/image/logo.png'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Text(
                              quizScreenController.randomizedQuestions.isEmpty
                                  ? ''
                                  : quizScreenController.currentQuestionIndex == quizScreenController.randomizedQuestions.length
                                      ? ''
                                      : '${quizScreenController.currentQuestionIndex + 1} / ${quizScreenController.randomizedQuestions.length}',
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 48.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 300,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.center,
                              image: AssetImage('assets/image/logo.png'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Expanded(
                  child: homeScreenController.quizStarted
                      ? QuizScreen()
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    '힌트 도우미를 선택해주세요.',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 30.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () => homeScreenController.selectedDoumiIndex = 0,
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/image/normal_mamekichi.png',
                                              width: homeScreenController.selectedDoumiIndex == 0 ? 100 : 60,
                                              height: homeScreenController.selectedDoumiIndex == 0 ? 100 : 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 42.0),
                                        GestureDetector(
                                          onTap: () => homeScreenController.selectedDoumiIndex = 1,
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/image/normal_sizue.png',
                                              width: homeScreenController.selectedDoumiIndex == 1 ? 100 : 60,
                                              height: homeScreenController.selectedDoumiIndex == 1 ? 100 : 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 42.0),
                                        GestureDetector(
                                          onTap: () => homeScreenController.selectedDoumiIndex = 2,
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/image/normal_june.png',
                                              width: homeScreenController.selectedDoumiIndex == 2 ? 100 : 60,
                                              height: homeScreenController.selectedDoumiIndex == 2 ? 100 : 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  homeScreenController.quizStarted = true;
                                },
                                style: ButtonStyle(
                                  backgroundColor: const WidgetStatePropertyAll(Colors.green),
                                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  )),
                                  fixedSize: const WidgetStatePropertyAll(Size(360.0, 120.0)),
                                ),
                                child: const Text(
                                  '퀴즈 시작 !!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
