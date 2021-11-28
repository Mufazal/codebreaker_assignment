import 'package:codebreaker_assignment/api/api_resource.dart';
import 'package:codebreaker_assignment/api/api_services.dart';
import 'package:codebreaker_assignment/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailProvider extends ChangeNotifier {
  PsResource model;
  bool isConnected;

  getMovieDetail(int id) async {
    // notifyListeners();
    Utils.checkInternetConnectivity().then((value) async {
      if (value) {
        model = await ApiServices.getMovieDetail(id);
        notifyListeners();
      } else {
        isConnected = false;
        notifyListeners();
      }
    });
  }
}
