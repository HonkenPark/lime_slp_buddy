import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lime_slp_buddy/main.dart';
import 'package:lime_slp_buddy/view/controller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.put(HomeScreenController());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: controller.quizStarted ? Container() : const Text('라임이의 SLP 퀴즈 도우미'),
        ),
        body: controller.quizStarted
            ? const QuizHomePage()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      children: [
                        Text(
                          '힌트 도우미',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_alarm),
                            Icon(Icons.access_alarm),
                            Icon(Icons.access_alarm),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.quizStarted = true;
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
    );
  }
}
