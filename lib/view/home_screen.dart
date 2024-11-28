import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lime_slp_buddy/main.dart';
import 'package:lime_slp_buddy/view/controller/home_screen_controller.dart';
import 'package:lime_slp_buddy/view/controller/quiz_screen_controller.dart';
import 'package:lime_slp_buddy/view/quiz_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
                                if (kIsWeb) {
                                  bool isOk = html.window.confirm('처음 화면으로 되돌아갈까요?');
                                  if (isOk) {
                                    homeScreenController.quizStarted = false;
                                    homeScreenController.selectedDoumiIndex = 0;
                                    homeScreenController.selectedQuizFile = QuizFileList.values.first;
                                    quizScreenController.currentQuestionIndex = 0;
                                    quizScreenController.doumiState = DoumiState.normal;
                                  }
                                } else {
                                  homeScreenController.quizStarted = false;
                                  homeScreenController.selectedDoumiIndex = 0;
                                  homeScreenController.selectedQuizFile = QuizFileList.values.first;
                                  quizScreenController.currentQuestionIndex = 0;
                                  quizScreenController.doumiState = DoumiState.normal;
                                }
                              },
                              iconSize: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 32.0 : 58.0,
                              color: Colors.pink,
                              icon: const Icon(
                                Icons.home,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 30 : 50,
                              width: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 200 : 300,
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
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 24.0 : 48.0,
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
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 250 : 350,
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      labelText: '퀴즈 선택',
                                      floatingLabelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    value: homeScreenController.selectedQuizFile.label,
                                    items: QuizFileList.values.map((QuizFileList file) {
                                      return DropdownMenuItem<String>(
                                        value: file.label,
                                        child: Text(file.label),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      homeScreenController.findQuiz(newValue!);
                                    },
                                  ),
                                ),
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
                                  fixedSize: WidgetStatePropertyAll(
                                    Size(
                                      (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 300 : 360.0,
                                      (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 100 : 120.0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '퀴즈 시작 !!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 28.0 : 36.0,
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
