import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/data/models/news_model/news_model.dart';

import '../../../core/theme/theme.dart';
import '../../../data/services/app_services.dart';
import '../providers/news_provider.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final AppServices appServices = Get.find<AppServices>();
  RxBool isDrawerOpened = RxBool(false);
  RxBool isClicked = false.obs;

  AnimationController? _animationController;
  AnimationController get animationController => _animationController!;
  Animation<double>? _animation;
  Animation get animation => _animation!;
  final NewsProvider provider = Get.find<NewsProvider>();
  RxBool isNewsLoading = false.obs;

  @override
  void onInit() {
    getAllNews();

    super.onInit();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(begin: kToolbarHeight, end: Get.height * 0.95).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
  }

  @override
  void onClose() {
    _animationController!.dispose();
  }

  NewsModel? newsList;
  getAllNews() async {
    isNewsLoading.value = true;
    NewsModel? response = await provider.getAllNews();
    if (response.totalResults == 0) {
      Ui.errorGetBar(message: 'No Data Returned, Please try again later');
      isNewsLoading.value = false;
    } else {
      if (response.status == 'ok') {
        if (response.articles!.isEmpty) {
          isNewsLoading.value = false;
          Ui.errorGetBar(message: 'No Articles have returned!!');
        } else {
          newsList = response;
          isNewsLoading.value = false;
        }
      } else {
        isNewsLoading.value = false;
        Ui.errorGetBar(message: 'Error has been , Please try again later');
      }
    }
    print(newsList!.articles!.length);
  }
}
