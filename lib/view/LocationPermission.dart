
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dialog.dart';
import 'SplashScreen.dart';

class LocationPermission extends StatefulWidget{
  const LocationPermission({super.key});


  @override
  State<StatefulWidget> createState()=>_LocationPermission();


}
class _LocationPermission extends State<LocationPermission>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppUtil.fullHeight(context)*0.1,),

                Center(child: Text("Location Permission",style: TextStyle(fontSize: 24,color: Colors.white),)),
                SizedBox(height: AppUtil.fullHeight(context)*0.05,),

                Center(child: Image.asset("images/map.png",height: 200,)),
                SizedBox(height: AppUtil.fullHeight(context)*0.05,),
                Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Text("Belilli requires your location while app in use so we can show nearby stores to your location. We are not saving the user’s location."
                      " We are not taking the location of the user. It's not compulsory for any users to provide us with the location.",
                    textAlign:TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.white),),
                )),
                SizedBox(height: AppUtil.fullHeight(context)*0.05,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.white),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () async {

                          SharedPreferences sp = await SharedPreferences.getInstance();

                          sp.setBool(userLocationBool, false);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) =>  SplashScreen()),
                              ModalRoute.withName("/splashView")

                          );

                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                          child: Text("Skip",style: TextStyle(fontSize: 14,color: primary),),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.blue),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () async {


                          showDialog(
                              context: context,
                              builder: (_) => CustomAlertDialog(
                                title: 'Location Permission',
                                description: 'This app collects location data to enable nearby stores, best Offer  in Shop, and nearest restaurants even when the app is closed or not in use.” If you extend permitted usage to ads, also include:',
                                onTap: () async {
                                  Permission.locationWhenInUse.request().then((value) async {

                                    if(value.isGranted)
                                    {
                                      SharedPreferences sp = await SharedPreferences.getInstance();

                                      sp.setBool(userLocationBool, true);

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  SplashScreen()),
                                          ModalRoute.withName("/splashView")

                                      );
                                    }
                                  });

                                },)
                          );









                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                          child: Text("Turn on",style: TextStyle(fontSize: 14,color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}