
import 'dart:io';

import 'package:belilli/appcomman/AppFont.dart';
import 'package:belilli/view/Dash/DashBoard.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:belilli/view/Dash/SearchFilterHome.dart';
import 'package:belilli/view/Dash/TakeOfferView.dart';
import 'package:belilli/view/MainSplashView.dart';
import 'package:belilli/view/profile/AccountView.dart';
import 'package:belilli/window/Enjoy1.dart';
import 'package:belilli/window/EnjoyInView.dart';
import 'package:belilli/window/ExpiredMember.dart';
import 'package:belilli/window/ForgetPassword.dart';
import 'package:belilli/window/LoginView.dart';
import 'package:belilli/window/RegisterView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appcomman/AppColor.dart';
import 'appcomman/AppRoute.dart';
import 'view/Dash/FilterView.dart';
import 'view/Dash/ProductDetails.dart';
import 'view/page/PrivacyPolicy.dart';
import 'view/profile/AccountDetailsView.dart';
import 'view/profile/CancelSubscription.dart';
import 'view/profile/ProfileView.dart';
import 'view/setting/SettingView.dart';

void main() {

  if(Platform.isAndroid) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light, // this will change the brightness of the icons
    statusBarColor: backgroundColor, // or any color you want
  ));
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() =>_MyApp();


}

class _MyApp extends State<MyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      setState((){});


    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BeLilli",
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigationKey,
      theme: ThemeData(
        fontFamily: primaryFont,

        primarySwatch: Colors.blue,
      ),
      routes: {
        "/login": (BuildContext context) =>  const LoginView(),
        "/register": (BuildContext context) =>  const RegisterView(),
        "/forgetPassword": (BuildContext context) =>  const ForgetPassword(),
        "/expiredMember": (BuildContext context) =>  const ExpiredMember(),
        "/enjoyIn": (BuildContext context) =>  const EnjoyInView(),
        "/enjoy1": (BuildContext context) =>  const Enjoy1(),
        "/dashBoard": (BuildContext context) => const DashBoard(),
        "/accountView": (BuildContext context) => const AccountView(),

        "/filterView": (BuildContext context) => const FilterView(),
        "/profileView": (BuildContext context) => const ProfileView(),
        "/settings": (BuildContext context) => const SettingView(),
        "/privacyPolicy": (BuildContext context) => const PrivacyPolicy(),
        "/productDetails": (BuildContext context) => const ProductDetails(),
        "/accountDetails": (BuildContext context) => const AccountDetailsView(),
        "/takeOfferView": (BuildContext context) => const TakeOfferView(),
        "/cancelSubscription": (BuildContext context) => const CancelSubscription(),
        "/searchFilterHome": (BuildContext context) => const SearchFilterHome(),
      },
      home: const MaimSplashView(),
    );
  }
}


