
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:belilli/view/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dash/DashBoard.dart';

class  MaimSplashView extends StatefulWidget
{
  const MaimSplashView({super.key});


  @override
  State<StatefulWidget> createState() =>_MaimSplashView();
}

class _MaimSplashView extends State<MaimSplashView> {

  String userId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp){

      userId = sp.getString(saveUserID)!=null ? sp.getString(saveUserID)!: "";

      sp.remove("filterList");
      sp.remove("radius");

    });

    setState(() {

    });

    Future.delayed(Duration(milliseconds: 2000), () {

      if(userId.isEmpty)
        {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  SplashScreen()),
              ModalRoute.withName("/splashView")

          );
        }
      else
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) =>  DashBoard()),
            ModalRoute.withName("/dashBoard")

        );
      }
      // Do something
    });
  }
  @override
  Widget build(BuildContext context) {
   return AnnotatedRegion<SystemUiOverlayStyle>(
     value: SystemUiOverlayStyle(
       statusBarColor: backgroundColor,
     ),
     child: Scaffold(
       body: SafeArea(
         child: Container(
           height: double.infinity,
           width: double.infinity,
           color: primary,

           child: Image.asset("images/splash.png",
             height: double.infinity,
             width: double.infinity,fit: BoxFit.fill,),
         ),
       ),
     ),
   );
  }
}