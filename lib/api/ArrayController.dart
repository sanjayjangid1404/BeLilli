
import 'dart:convert';
import 'package:belilli/Model/RequestModel/BusinessFilterRequest.dart';
import 'package:belilli/Model/ResponseModel/BusinessResponse.dart';
import 'package:belilli/Model/ResponseModel/FeaturedListResponse.dart';
import 'package:http/http.dart' as http;

import '../Model/RequestModel/FavListRequest.dart';
import '../Model/RequestModel/SimpleRequest.dart';
import '../Model/ResponseModel/CategoryListResponse.dart';
import '../Model/ResponseModel/FavouriteResponse.dart';
import '../Model/ResponseModel/GetActivityResponse.dart';
import '../appcomman/AppUtil.dart';

class ArrayController {

  Future<CategoryListResponse?> getAllCategory() async {



    final response = await http.get(Uri.parse("http://belilli.co.uk/api.php?function=getcategories"));
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(response.body.isNotEmpty ? json.decode(response.body) : "");
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      if (statusCode == 200) {
        final CategoryListResponse imgList =CategoryListResponse.fromJson(json.decode(response.body));


        return imgList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<BusinessResponse?> getAllBusiness(BusinessFilterRequest requestModel) async {
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("http://belilli.co.uk/api.php?function=getbusinesses"),body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(response.body.isNotEmpty ? json.decode(response.body) : "");
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      if (statusCode == 200) {
        final BusinessResponse imgList =BusinessResponse.fromJson(json.decode(response.body));


        return imgList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<FeaturedListResponse?> getAllFeatured(BusinessFilterRequest requestModel) async {
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("http://belilli.co.uk/api.php?function=getfeaturedbusinesses"),body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(response.body.isNotEmpty ? json.decode(response.body) : "");
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      if (statusCode == 200) {
        final FeaturedListResponse imgList =FeaturedListResponse.fromJson(json.decode(response.body));


        return imgList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<FavouriteResponse?> getAllFavouriteList(FavListRequest requestModel) async {
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("http://belilli.co.uk/api.php?function=getuserfavourites"),
        body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(response.body.isNotEmpty ? json.decode(response.body) : "");
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      if (statusCode == 200) {
        final FavouriteResponse imgList =FavouriteResponse.fromJson(json.decode(response.body));


        return imgList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data!');
    }
  }


  Future<GetActivityResponse?> getAllActivity(SimpleRequest requestModel) async {
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("http://belilli.co.uk/api.php?function=getactivityhistory"),
        body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(response.body.isNotEmpty ? json.decode(response.body) : "");
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      if (statusCode == 200) {
        final GetActivityResponse imgList =GetActivityResponse.fromJson(json.decode(response.body));


        return imgList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data!');
    }
  }
}