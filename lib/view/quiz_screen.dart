import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lime_slp_buddy/view/controller/home_screen_controller.dart';
import 'package:lime_slp_buddy/view/controller/quiz_screen_controller.dart';

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
        await quizScreenController.loadQuizData();
      },
      builder: (_) {
        return Obx(
          () => quizScreenController.randomizedQuestions.isNotEmpty && (quizScreenController.currentQuestionIndex >= quizScreenController.randomizedQuestions.length)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '퀴즈가 끝났습니다. 참 잘했어요 🥰\n아빠에게 만세를 해달라고 하세요 !!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 80),
                      ClipOval(
                        child: Image.asset(
                          'assets/image/finish_tanukichi.png', // good job or Nugul clap
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ClipOval(
                        child: Image.asset(
                          quizScreenController.getImagePath(homeScreenController.selectedDoumiIndex),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 500,
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
                              style: const TextStyle(
                                fontSize: 24.0,
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
                          // const SizedBox(width: 30),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     quizScreenController.checkAnswer(answerController.text.trim().toLowerCase());
                          //   },
                          //   style: ButtonStyle(
                          //     backgroundColor: const WidgetStatePropertyAll(Colors.purpleAccent),
                          //     shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(12.0),
                          //     )),
                          //   ),
                          //   child: const Padding(
                          //     padding: EdgeInsets.all(12.0),
                          //     child: Text(
                          //       '정답 확인',
                          //       style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   alignment: Alignment.center,
                        //   height: 90,
                        //   padding: const EdgeInsets.all(12.0),
                        //   decoration: BoxDecoration(
                        //     color: Colors.amberAccent,
                        //     borderRadius: BorderRadius.circular(12.0),
                        //   ),
                        //   child: Text(
                        //     quizScreenController.randomizedQuestions.isEmpty ? '' : quizScreenController.randomizedQuestions[quizScreenController.currentQuestionIndex]['descriptions']['meaning_k'],
                        //     style: const TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 24.0,
                        //     ),
                        //   ),
                        // ),
                        Container(
                          alignment: Alignment.center,
                          height: 90,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            quizScreenController.randomizedQuestions.isEmpty ? '' : quizScreenController.randomizedQuestions[quizScreenController.currentQuestionIndex]['descriptions']['meaning_e'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 90,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            quizScreenController.randomizedQuestions.isEmpty ? '' : quizScreenController.randomizedQuestions[quizScreenController.currentQuestionIndex]['descriptions']['sentence'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}
