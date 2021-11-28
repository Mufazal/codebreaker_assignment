import 'package:flutter/cupertino.dart';
import 'package:codebreaker_assignment/api/api_resource.dart';
import 'package:codebreaker_assignment/api/api_services.dart';
import 'package:codebreaker_assignment/utils/utils.dart';

class MovieListProvider extends ChangeNotifier {
  PsResource model;
  bool isConnected;
  bool loading;
  getMovies() async {
    // notifyListeners();
    loading = false;
    Utils.checkInternetConnectivity().then((value) async {
      print(value);
      if (value) {
        model = await ApiServices.getMoviesList();
        notifyListeners();
      } else {
        isConnected = false;
        notifyListeners();
      }
    });
  }
}
