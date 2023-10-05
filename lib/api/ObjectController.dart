
import 'dart:convert';

import 'package:belilli/Model/RequestModel/ForgetPassword.dart';
import 'package:belilli/Model/RequestModel/ProfileUpdateRequest.dart';

import '../Model/RequestModel/AddFavouriteRequest.dart';
import '../Model/RequestModel/AddSubscriptionRequest.dart';
import '../Model/RequestModel/BusinessDetailsRequest.dart';
import '../Model/RequestModel/LoginRequest.dart';
import '../Model/RequestModel/RegisterRequestModel.dart';
import '../Model/RequestModel/RemoveFavRequest.dart';
import '../Model/RequestModel/SearchItemFavRequest.dart';
import '../Model/RequestModel/SubscriptionRequest.dart';
import '../Model/ResponseModel/BusinessDetailsResponse.dart';
import '../Model/ResponseModel/LoginResponse.dart';
import '../Model/ResponseModel/RedeemOfferResponse.dart';
import '../Model/ResponseModel/RegisterResponse.dart';
import '../Model/ResponseModel/SearchResponse.dart';
import '../Model/ResponseModel/SimpleResponse.dart';
import '../Model/ResponseModel/SubscriptionResponse.dart';
import '../appcomman/AppUtil.dart';
import 'ApiURL.dart';
import 'package:http/http.dart' as http;

class ObjectController
{

  loginCallAPI(LoginRequest requestModel) async {
    String authority = baseURL;
     String apiUrl = loginAPI;
    final apiURI = Uri.https(authority, apiUrl);
    AppUtil.appLogs("--------------WebService---------------");
    AppUtil.appLogs(apiURI);
    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=login"), body: requestModel.toJson());
    AppUtil.appLogs(json.decode(response.body));
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final LoginResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = LoginResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = LoginResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      /*final LoginResponse responseModel;
      responseModel = LoginResponse.fromJson(json.decode(response.body));*/
      return null;
      throw Exception('Failed to load data!');
    }
  }


  updateSubscriptionAPI(SubscriptionRequest requestModel) async {
    String authority = baseURL;
     String apiUrl = loginAPI;
    final apiURI = Uri.https(authority, apiUrl);
    AppUtil.appLogs("--------------WebService---------------");
    AppUtil.appLogs(apiURI);
    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=updatesubscriptionandroid"), body: requestModel.toJson());
    AppUtil.appLogs(json.decode(response.body));
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final SubscriptionResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = SubscriptionResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = SubscriptionResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      /*final LoginResponse responseModel;
      responseModel = LoginResponse.fromJson(json.decode(response.body));*/
      return null;
      throw Exception('Failed to load data!');
    }
  }


  registerCallAPI(RegisterRequestModel requestModel) async {
    String authority = baseURL;
     String apiUrl = loginAPI;
    final apiURI = Uri.https(authority, apiUrl);
    AppUtil.appLogs("--------------WebService---------------");
    AppUtil.appLogs(apiURI);
    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=register"),
        body: requestModel.toJson());
    AppUtil.appLogs(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final RegisterResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = RegisterResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = RegisterResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    }
    else {
      final RegisterResponse responseModel;
      // AppUtil.appLogs(jsonDecode(response.body.toString()));
      // AppUtil.showToast(json.decode(response.body)["message"], "e");
      return null;
      throw Exception('Failed to load data!');
    }
  }


  forgetPassword(ForgetPassword requestModel) async {
    String authority = baseURL;
     String apiUrl = loginAPI;
    final apiURI = Uri.https(authority, apiUrl);
    AppUtil.appLogs("--------------WebService---------------");
    AppUtil.appLogs(apiURI);
    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=resetpassword"), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final SimpleResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      final SimpleResponse responseModel;
      responseModel = SimpleResponse.fromJson(json.decode(response.body));
      return responseModel;
      throw Exception('Failed to load data!');
    }
  }


  updateProfile(ProfileUpdateRequest requestModel) async {

    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=updateprofile"), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final SimpleResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      final SimpleResponse responseModel;
      responseModel = SimpleResponse.fromJson(json.decode(response.body));
      return responseModel;
      throw Exception('Failed to load data!');
    }
  }

  businessDetailsAPI(BusinessDetailsRequest requestModel) async {

    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=getbusinessdetail"), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final BusinessDetailsResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = BusinessDetailsResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = BusinessDetailsResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      final BusinessDetailsResponse responseModel;
      responseModel = BusinessDetailsResponse.fromJson(json.decode(response.body));
      return responseModel;
      throw Exception('Failed to load data!');
    }
  }

  addBusinessFev(AddFavouriteRequest requestModel) async {

    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=addtofavourite"), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final SimpleResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      final SimpleResponse responseModel;
      responseModel = SimpleResponse.fromJson(json.decode(response.body));
      return responseModel;
      throw Exception('Failed to load data!');
    }
  }

  redeemOffer(AddFavouriteRequest requestModel) async {

    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=redeemoffer"), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final RedeemOfferResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = RedeemOfferResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = RedeemOfferResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      final RedeemOfferResponse responseModel;
      responseModel = RedeemOfferResponse.fromJson(json.decode(response.body));
      return responseModel;
      throw Exception('Failed to load data!');
    }
  }

  removeBusinessFev(RemoveFavRequest requestModel) async {

    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=deletefavourite"), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final SimpleResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      final SimpleResponse responseModel;
      responseModel = SimpleResponse.fromJson(json.decode(response.body));
      return responseModel;
      throw Exception('Failed to load data!');
    }
  }


  searchQueryItem(SearchItemFavRequest requestModel) async {

    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=searchbusinesses"), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final SearchResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = SearchResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = SearchResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      final SearchResponse responseModel;
      responseModel = SearchResponse.fromJson(json.decode(response.body));
      return responseModel;
      throw Exception('Failed to load data!');
    }
  }

  subscriptionUpdate(SubscriptionRequest requestModel) async {

    AppUtil.appLogs("--------------Parameter---------------");
    AppUtil.appLogs(requestModel.toJson());
    final response = await http.post(Uri.parse("https://www.belilli.co.uk/api.php?function=updatesubscriptionandroid"), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      AppUtil.appLogs("--------------Response---------------");
      AppUtil.appLogs(json.decode(response.body));
      int statusCode = response.statusCode;
      AppUtil.appLogs("--------------Status Code---------------");
      AppUtil.appLogs(statusCode);
      final SimpleResponse responseModel;
      if (statusCode == 200 || response.statusCode == 400) {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        responseModel = SimpleResponse.fromJson(json.decode(response.body));
        return responseModel;
        throw Exception('Failed to load data!');
        // return loginResponse;

      }
    } else {
      final SimpleResponse responseModel;
      responseModel = SimpleResponse.fromJson(json.decode(response.body));
      return responseModel;
      throw Exception('Failed to load data!');
    }
  }
}