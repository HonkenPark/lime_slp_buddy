import 'package:get/get.dart';
import 'package:lime_slp_buddy/main.dart';

class HomeScreenController extends GetxController {
  final RxBool _isQuizStarted = false.obs;
  bool get quizStarted => _isQuizStarted.value;
  set quizStarted(bool value) => _isQuizStarted.value = value;

  final RxInt _selectedDoumiIndex = 0.obs;
  int get selectedDoumiIndex => _selectedDoumiIndex.value;
  set selectedDoumiIndex(int value) => _selectedDoumiIndex.value = value;

  final Rx<QuizFileList> _selectedQuizFile = QuizFileList.values.first.obs;
  QuizFileList get selectedQuizFile => _selectedQuizFile.value;
  set selectedQuizFile(QuizFileList value) => _selectedQuizFile.value = value;
  void findQuiz(String label) {
    var result = QuizFileList.values.firstWhere((value) => value.label == label);
    selectedQuizFile = result;
  }
}
