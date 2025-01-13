import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lime_slp_buddy/main.dart';
import 'package:lime_slp_buddy/view/controller/home_screen_controller.dart';
import 'package:lime_slp_buddy/view/controller/quiz_screen_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  QuizScreenController quizScreenController = Get.find();
  HomeScreenController homeScreenController = Get.find();

  final TextEditingController answerController = TextEditingController();
  final FocusNode answerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizScreenController>(
      initState: (_) async {
        await quizScreenController.loadQuizData(homeScreenController.selectedQuizFile.path);
      },
      builder: (_) {
        return Obx(
          () => quizScreenController.randomizedQuestions.isNotEmpty && (quizScreenController.currentQuestionIndex >= quizScreenController.randomizedQuestions.length)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '퀴즈가 끝났습니다. 참 잘했어요 🥰\n엄마에게 로블록스를 해달라고 하세요 !!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 18.0 : 48.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 20 : 80),
                      ClipOval(
                        child: Image.asset(
                          'assets/image/finish_tanukichi.png', // good job or Nugul clap
                          width: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 150 : 300,
                          height: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 150 : 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 100 : 200),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all((ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 12.0 : 24.0),
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              quizScreenController.getWrongInputImagePath(homeScreenController.selectedDoumiIndex),
                              width: quizScreenController.doumiState != DoumiState.wronginput
                                  ? 0
                                  : (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone)
                                      ? 130
                                      : 200,
                              height: quizScreenController.doumiState != DoumiState.wronginput
                                  ? 0
                                  : (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone)
                                      ? 130
                                      : 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              quizScreenController.getWrongAnswerImagePath(homeScreenController.selectedDoumiIndex),
                              width: quizScreenController.doumiState != DoumiState.wronganswer
                                  ? 0
                                  : (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone)
                                      ? 130
                                      : 200,
                              height: quizScreenController.doumiState != DoumiState.wronganswer
                                  ? 0
                                  : (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone)
                                      ? 130
                                      : 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              quizScreenController.getCorrectAnswerImagePath(homeScreenController.selectedDoumiIndex),
                              width: quizScreenController.doumiState != DoumiState.correctanswer
                                  ? 0
                                  : (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone)
                                      ? 130
                                      : 200,
                              height: quizScreenController.doumiState != DoumiState.correctanswer
                                  ? 0
                                  : (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone)
                                      ? 130
                                      : 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              quizScreenController.getNormalImagePath(homeScreenController.selectedDoumiIndex),
                              width: quizScreenController.doumiState != DoumiState.normal
                                  ? 0
                                  : (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone)
                                      ? 130
                                      : 200,
                              height: quizScreenController.doumiState != DoumiState.normal
                                  ? 0
                                  : (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone)
                                      ? 130
                                      : 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 12.0 : 24.0,
                        horizontal: 64.0,
                      ),
                      child: TextFormField(
                        controller: answerController,
                        focusNode: answerFocusNode,
                        autofocus: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),
                        ],
                        style: TextStyle(
                          fontSize: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 18.0 : 24.0,
                        ),
                        decoration: const InputDecoration(
                          labelText: '입력해주세요',
                          contentPadding: EdgeInsets.all(12.0),
                        ),
                        onChanged: (value) {
                          quizScreenController.liveChecking(value.trim().toLowerCase());
                        },
                        onFieldSubmitted: (value) {
                          quizScreenController.checkAnswer(value.trim().toLowerCase());
                          answerController.clear();
                          answerFocusNode.requestFocus();
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (quizScreenController.toggleKoreanMeaning)
                          Container(
                            alignment: Alignment.center,
                            // height: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 70 : 90,
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              quizScreenController.randomizedQuestions.isEmpty ? '' : quizScreenController.randomizedQuestions[quizScreenController.currentQuestionIndex]['descriptions']['meaning_k'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 14.0 : 24.0,
                              ),
                            ),
                          ),
                        Container(
                          alignment: Alignment.center,
                          // height: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 70 : 90,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            quizScreenController.randomizedQuestions.isEmpty ? '' : quizScreenController.randomizedQuestions[quizScreenController.currentQuestionIndex]['descriptions']['meaning_e'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 14.0 : 24.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          // height: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 70 : 90,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            quizScreenController.randomizedQuestions.isEmpty ? '' : quizScreenController.randomizedQuestions[quizScreenController.currentQuestionIndex]['descriptions']['sentence'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 14.0 : 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: (ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isPhone) ? 300 : 100),
                  ],
                ),
        );
      },
    );
  }
}
