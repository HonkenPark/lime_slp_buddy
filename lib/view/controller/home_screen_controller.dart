import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final RxBool _isQuizStarted = false.obs;
  bool get quizStarted => _isQuizStarted.value;
  set quizStarted(bool value) => _isQuizStarted.value = value;

  final RxInt _selectedDoumiIndex = 0.obs;
  int get selectedDoumiIndex => _selectedDoumiIndex.value;
  set selectedDoumiIndex(int value) => _selectedDoumiIndex.value = value;
}
