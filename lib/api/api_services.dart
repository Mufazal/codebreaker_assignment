import 'dart:convert';

import 'package:codebreaker_assignment/api/api.dart';
import 'package:codebreaker_assignment/api/api_resource.dart';
import 'package:codebreaker_assignment/api/api_response.dart';
import 'package:codebreaker_assignment/api/api_status.dart';
import 'package:codebreaker_assignment/constant/const.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static getMoviesList() async {
    try {
      // Dio dio = Dio();
      Uri uri = Uri.parse("${Api.getImagesList}");
      var response = await http
          .get(
        uri,
      )
          .catchError((e) {
        print("Error get Data");
        return PsResource(
            status: PsStatus.ERROR, message: "Connection Error", data: null);
      });

      print(response.statusCode);

      print(response.body.toString());
      ApiResponse apiResponse = ApiResponse(response);

      if (apiResponse.isSuccessful()) {
        return PsResource(
            list: json.decode(response.body),
            message: "",
            status: PsStatus.SUCCESS);
      } else {
        return PsResource(
            status: PsStatus.ERROR,
            message: apiResponse.errorMessage,
            data: null);
      }
    } catch (e) {
      print(e.toString());
      return PsResource(
          status: PsStatus.ERROR, message: e.errorMessage, data: null);
      //e.message ??
    }

    // if (response.statusCode == 200) {
    //   if (response.statusCode != null) {
    //     return MovieList.fromJson(jsonDecode(response.body));
    //   } else {
    //     return null;
    //   }
    // }
  }

  static Future<PsResource> getMovieDetail(int movieID) async {
    // Dio dio = Dio();

    try {
      Uri uri = Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieID?api_key=${Constants.API_KEY}");
      var response = await http
          .get(
        uri,
      )
          .catchError((e) {
        print("Error get Data");
        return PsResource(
            status: PsStatus.ERROR, message: "Connection Error", data: null);
      });

      ApiResponse apiResponse = ApiResponse(response);

      if (apiResponse.isSuccessful()) {
        return PsResource(
            data: json.decode(response.body),
            message: "",
            status: PsStatus.SUCCESS);
      } else {
        return PsResource(
            status: PsStatus.ERROR,
            message: apiResponse.errorMessage,
            data: null);
      }
    } catch (e) {
      print(e.toString());
      return PsResource(
          status: PsStatus.ERROR, message: e.errorMessage, data: null);
      //e.message ??
    }

    // print(response.statusCode);

    // print(response.body.toString());

    // if (response.statusCode == 200) {
    //   if (response.statusCode != null) {
    //     return MovieDetail.fromJson(jsonDecode(response.body));
    //   } else {
    //     return null;
    //   }
    // }
  }
}
