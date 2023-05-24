
import 'package:belilli/Model/RequestModel/LoginRequest.dart';
import 'package:belilli/Model/ResponseModel/LoginResponse.dart';
import 'package:belilli/api/ObjectController.dart';
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:belilli/view/SplashScreen.dart';
import 'package:belilli/window/RegisterView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/Dash/DashBoard.dart';
import '../view/Dialog.dart';
import 'ForgetPassword.dart';


enum PermissionGroup {
  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
}

class LoginView extends StatefulWidget{
  const LoginView({super.key});


  @override
  State<StatefulWidget> createState()=>_LoginView();
}

class _LoginView extends State<LoginView> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool     _passwordVisible = false;
   Permission? _permission ;




  Future<bool> _onWillPop() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  SplashScreen()),
        ModalRoute.withName("/splashView")

    );
    return true; //
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/background1.png")
                    )
                ),

              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                child: IconButton(onPressed: (){
                  _onWillPop();
                }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
              ),

              Container(
                padding: EdgeInsets.only(top: AppUtil.fullHeight(context)*0.03),
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [


                   Center(child: Image.asset("images/logo2.png",height: AppUtil.fullHeight(context)*0.04,)),

                    SizedBox(height: AppUtil.fullHeight(context)*0.02,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(

                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 37),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 34,),
                            Center(
                              child: Text("Let me in!",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 23,color: Color(0xFF4d40fa),fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 20,),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
                              child: SizedBox(
                                height: 45,
                                child: TextField(

                                  controller: email,
                                  autofocus: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Email address',
                                    hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.w800,color: Color(0xFF454545)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      borderSide: BorderSide(color: Color(0xFFdbd3f4), width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      borderSide: BorderSide(color: Color(0xFFdbd3f4), width: 1),
                                    ),



                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green,width: 0.4),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                    fillColor: Color(0xFFF8F9FA),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
                              child: SizedBox(
                                height: 45,
                                child: TextField(
                                  autofocus: true,
                                  controller: password,
                                  keyboardType: TextInputType.text,
                                  obscureText: !_passwordVisible,
                                  obscuringCharacter: ".",
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.w800,color: Color(0xFF454545)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      borderSide: BorderSide(color: Color(0xFFdbd3f4), width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      borderSide: BorderSide(color: Color(0xFFdbd3f4), width: 1),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible?
                                        Icons.visibility:Icons.visibility_off
                                        ,
                                        color: _passwordVisible?Theme.of(context).primaryColor:
                                        greyColor,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toggle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green,width: 0.4),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                    fillColor: Color(0xFFF8F9FA),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 7,),

                            InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword(),));
                                },
                                child: Text("I think I forgot my password…",style: TextStyle(fontSize: 11,color: Color(0xFF4d40fa),fontWeight: FontWeight.bold),)),

                            SizedBox(height: 25,),

                            InkWell(
                              onTap: ()  async {

                                if(email.text.toString().trim().isEmpty)
                                {

                                  AppUtil.showToast("Enter email", "e");

                                }
                                else if(password.text.toString().trim().isEmpty)
                                {

                                  AppUtil.showToast("Enter password", "e");

                                }

                                else
                                {
                                  setState(() {
                                    isLoading=  true;
                                  });

                                  LoginRequest requestModel = LoginRequest("", "");

                                  requestModel.username = email.text.toString().trim();
                                  requestModel.password = password.text.toString().trim();
                                  ObjectController controller = ObjectController();
                                  controller.loginCallAPI(requestModel).then((value) async {



                                    LoginResponse response = value;

                                    if(response.error==false && response.data!=null)
                                    {

                                      SharedPreferences sp = await SharedPreferences.getInstance();

                                      sp.setString(saveUserEmail, response.data!.email.toString());
                                      sp.setString(saveUserID, response.data!.id.toString());
                                      sp.setString(saveUserFirst, response.data!.firstName.toString());
                                      sp.setString(saveUserLast, response.data!.lastName.toString());
                                      sp.setString(saveUserStatus, response.data!.status.toString());
                                      sp.setString(saveUserPassword, response.data!.password.toString());
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  DashBoard()),
                                          ModalRoute.withName("/dashBoard")

                                      );
                                    }

                                    setState(() {
                                      isLoading=  false;
                                    });
                                  });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 3,vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: isLoading ? Colors.white : primary,
                                ),

                                child:Text("Enter",style: TextStyle(fontSize: 16,color: isLoading ? Colors.black : Colors.white,fontWeight: FontWeight.w800),),
                              ),
                            ),

                            SizedBox(height: 20,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don’t have an account?",style: TextStyle(fontSize: 12,color: Color(0xFF454545),fontWeight: FontWeight.bold)),


                                SizedBox(width: 10,),

                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView(),));
                                    },
                                    child: Text("Register now",style: TextStyle(fontSize: 12,color: Color(0xFFe6543a),fontWeight: FontWeight.bold))),
                              ],
                            ),
                            SizedBox(height: 10,),



                          ],
                        ),
                      ),
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

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}