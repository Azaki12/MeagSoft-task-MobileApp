import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController _pageController = PageController(initialPage: 0);
  int length = 5;
  RxInt cindex = 0.obs;

  PageController get pageController => _pageController;

  void next() {
    if (cindex.value < length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      cindex.value++;
    }
  }

  void lastPage() {
    if (cindex.value >= 0) {
      _pageController.animateToPage(length - 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      cindex.value--;
    }
  }

  @override
  void onClose() {
    _pageController.dispose();
  }
}
