import 'package:assignment/src/constants/string_constants.dart';
import 'package:assignment/src/features/home/model/res_home_model.dart';
import 'package:assignment/src/service/api_service.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Article> _home = [];

  List<Article> get home => _home;

  Future<void> getHomeData({required String code}) async {
    isLoading = true;
    notifyListeners();
    await ApiService().getHomeAPI(code: code).then((value) {
      if (value?.status == 'ok') {
        _home = value?.articles ?? [];
        isLoading = false;
      }
    });
    notifyListeners();
  }
}
