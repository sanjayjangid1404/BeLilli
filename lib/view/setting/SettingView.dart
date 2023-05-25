
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../appcomman/AppColor.dart';
import '../../appcomman/AppRoute.dart';
import '../Dialog.dart';

class SettingView extends StatefulWidget{
  const SettingView({super.key});


  @override
  State<StatefulWidget> createState()=>_SettingView();
}

class _SettingView extends State<SettingView> {
  bool location = false;
  bool weekly = false;
  bool monthly = false;
  bool never = false;
  String userId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp) {
      location = sp.getBool(saveLocation)!=null ? sp.getBool(saveLocation)!:false;
      weekly = sp.getBool(saveWeekly)!=null ? sp.getBool(saveWeekly)!:false;
      monthly = sp.getBool(saveMonthly)!=null ? sp.getBool(saveMonthly)!:false;
      never = sp.getBool(saveNever)!=null ? sp.getBool(saveNever)!:false;
      userId= sp.getString(saveUserID)!=null ? sp.getString(saveUserID)!: "";


      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: backgroundColor,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                          NavigationService.instance.navigatePopAndPushNamed("/accountView");
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text("Settings",
                          style: TextStyle(fontSize: 18,color: Colors.white),),
                      ),
                    ),


                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 38,),
                    userId =="7" ? SizedBox() :
                    Text("Location",style: TextStyle(fontSize: 16,color: Colors.white),),

                    SizedBox(height: 7,),
                    userId =="7" ? SizedBox() : Text("We would love to know your location so we can show \nyou rewards closest to you. Would that be ok?",
                      style: TextStyle(fontSize: 8.4,color: Color(0xFFdbd3f4)),),
                    SizedBox(height: 19,),
                    userId =="7" ? SizedBox() : SwitchListTile(
                      title: Text('Turn location on',style: TextStyle(
                          color: Colors.white,

                          fontSize: 13
                      ),
                      ),
                      value: location,
                      activeColor: Colors.white,
                      activeTrackColor: Color(0xFFE87A67),
                      contentPadding: EdgeInsets.zero,
                      inactiveThumbColor: Color(0xFFE87A67),
                      inactiveTrackColor: Colors.white,
                      onChanged: (bool value) async {

                        if(value) {
                          showDialog(
                              context: context,
                              builder: (_) => CustomAlertDialog(
                                title: 'Location Permission',
                                description: 'This app collects location data to enable nearby stores, best Offer  in Shop, and nearest restaurants even when the app is closed or not in use.” If you extend permitted usage to ads, also include:',
                                onTap: () async {
                                  SharedPreferences sp = await SharedPreferences.getInstance();


                                  setState(()  {
                                    location = value;
                                    sp.setBool(saveLocation, location);
                                  });

                                },)
                          );
                        }
                        else
                        {
                          SharedPreferences sp = await SharedPreferences.getInstance();


                          setState(()  {
                            location = value;
                            sp.setBool(saveLocation, location);
                          });
                        }


                      },
                    ),
                    SizedBox(height: 20,),
                    Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                    SizedBox(height: 35,),
                    Text("Notification",style: TextStyle(fontSize: 16,color: Colors.white),),
                    SizedBox(height: 7,),
                    Text("Would you love to hear from the Belilli community:",
                      style: TextStyle(fontSize: 8.4,color: Color(0xFFdbd3f4)),),
                    SizedBox(height: 19,),
                    SwitchListTile(
                      title: Text('Weekly',style: TextStyle(
                          color: Colors.white,

                          fontSize: 13
                      ),
                      ),
                      value: weekly,
                      activeColor: Colors.white,
                      activeTrackColor: Color(0xFFE87A67),
                      contentPadding: EdgeInsets.zero,
                      inactiveThumbColor: Color(0xFFE87A67),
                      inactiveTrackColor: Colors.white,
                      onChanged: (bool value) async{

                        SharedPreferences sp = await SharedPreferences.getInstance();


                        setState(()  {
                          weekly = value;
                          sp.setBool(saveWeekly, weekly);
                        });
                      },
                    ),
                    SizedBox(height: 18,),
                    SwitchListTile(
                      title: Text('Monthly',style: TextStyle(
                          color: Colors.white,

                          fontSize: 13
                      ),
                      ),
                      value: monthly,
                      activeColor: Colors.white,
                      activeTrackColor: Color(0xFFE87A67),
                      contentPadding: EdgeInsets.zero,
                      inactiveThumbColor: Color(0xFFE87A67),
                      inactiveTrackColor: Colors.white,
                      onChanged: (bool value) async{

                        SharedPreferences sp = await SharedPreferences.getInstance();


                        setState(()  {
                          monthly = value;
                          sp.setBool(saveMonthly, monthly);
                        });
                      },
                    ),
                    SizedBox(height: 18,),
                    SwitchListTile(
                      title: Text('Never',style: TextStyle(
                          color: Colors.white,

                          fontSize: 13
                      ),
                      ),
                      value: never,
                      activeColor: Colors.white,

                      activeTrackColor: Color(0xFFE87A67),
                      contentPadding: EdgeInsets.zero,
                      inactiveThumbColor: Color(0xFFE87A67),
                      inactiveTrackColor: Colors.white,
                      onChanged: (bool value) async{

                        SharedPreferences sp = await SharedPreferences.getInstance();


                        setState(()  {
                          never = value;
                          sp.setBool(saveNever, never);
                        });
                      },
                    ),

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}