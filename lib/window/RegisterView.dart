
import 'dart:io';

import 'package:belilli/Model/RequestModel/RegisterRequestModel.dart';
import 'package:belilli/Model/ResponseModel/RegisterResponse.dart';
import 'package:belilli/api/ObjectController.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:belilli/window/LoginView.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appcomman/AppColor.dart';
import '../appcomman/AppVariable.dart';
import '../view/SplashScreen.dart';
import 'Enjoy1.dart';

class RegisterView extends StatefulWidget{
  const RegisterView({super.key});


  @override
  State<StatefulWidget> createState() =>_RegisterView();
}

class _RegisterView extends State<RegisterView> {
  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cnfPassword = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();

  bool isLoading  = false;
  String deviceId = "";

  String token = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp) async {




      setState((){});


    });
  }


  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.device; // unique ID on Android
    }
  }


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
               child:Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Center(child: Image.asset("images/logo2.png",height: AppUtil.fullHeight(context)*0.04,)),
                   Expanded(
                     child: Align(
                       alignment: Alignment.bottomCenter,
                       child: SingleChildScrollView(
                         child: Container(

                           width: double.infinity,
                           padding: EdgeInsets.symmetric(horizontal: 35),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                               color: Colors.white
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               SizedBox(height: 33,),
                               Center(
                                 child: Text("Register",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(fontSize: 23,color: primary,fontWeight: FontWeight.bold),),
                               ),
                               SizedBox(height: 15,),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                                 child: SizedBox(
                                   height: 45,
                                   child: TextField(

                                     controller: fName,
                                     keyboardType: TextInputType.text,
                                     decoration: InputDecoration(
                                       hintText: 'First name',
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
                                 padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                                 child: SizedBox(
                                   height: 45,
                                   child: TextField(

                                     controller: lName,
                                     keyboardType: TextInputType.text,
                                     decoration: InputDecoration(
                                       hintText: 'Last name',
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
                                 padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                                 child: SizedBox(
                                   height: 45,
                                   child: TextField(

                                     controller: email,
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
                                 padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                                 child: SizedBox(
                                   height: 45,
                                   child: TextField(

                                     controller: password,
                                     keyboardType: TextInputType.text,
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
                                 padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                                 child: SizedBox(
                                   height: 45,
                                   child: TextField(

                                     controller: cnfPassword,
                                     keyboardType: TextInputType.text,
                                     decoration: InputDecoration(
                                       hintText: 'Confirm Password',
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
                               SizedBox(height: 20,),

                               InkWell(
                                 onTap: () async {
                                  /* Navigator.pushAndRemoveUntil(
                                       context,
                                       MaterialPageRoute(builder: (context) =>  Enjoy1()),
                                       ModalRoute.withName("/enjoy1")

                                   );*/
                                   if(fName.text.toString().trim().isEmpty)
                                   {
                                     AppUtil.showToast("Enter first name", "s");
                                   }

                                   else if(lName.text.toString().trim().isEmpty)
                                   {
                                     AppUtil.showToast("Enter last name", "s");
                                   }

                                   else if(email.text.toString().trim().isEmpty)
                                   {
                                     AppUtil.showToast("Enter email", "s");
                                   }

                                   else if(password.text.toString().trim().isEmpty)
                                   {
                                     AppUtil.showToast("Enter password", "s");
                                   }

                                   else if(cnfPassword.text.toString().trim().isEmpty)
                                   {
                                     AppUtil.showToast("Re-Enter password", "s");
                                   }

                                   else if(cnfPassword.text.toString().trim()!=password.text.toString().trim())
                                   {
                                     AppUtil.showToast("Password not same", "s");
                                   }

                                   else
                                   {

                                     String?token = await FirebaseMessaging.instance.getToken();
                                     RegisterRequestModel requestModel = RegisterRequestModel("", "", "", "", "", "");

                                     requestModel.first_name = fName.text.toString().trim();
                                     requestModel.last_name = lName.text.toString().trim();
                                     requestModel.username = email.text.toString().trim();
                                     requestModel.password = password.text.toString().trim();
                                     requestModel.device_id = token!;
                                     requestModel.device_type = Platform.isAndroid ? "Android" : "IOS";

                                     ObjectController controller = ObjectController();

                                     setState(() {
                                       isLoading=  true;
                                     });

                                     controller.registerCallAPI(requestModel).then((value) async {

                                       if(value!=null)
                                         {
                                           RegisterResponse response = value;

                                           if(response.error==false && response.data!=null)
                                           {
                                             SharedPreferences sp = await SharedPreferences.getInstance();

                                             sp.setString(saveUserEmail, response.data!.email.toString());
                                             sp.setString(saveUserID, response.data!.id.toString());
                                             sp.setString(saveUserFirst, response.data!.firstName.toString());
                                             sp.setString(saveUserLast, response.data!.lastName.toString());
                                             sp.setString(saveUserStatus, response.data!.status.toString());
                                             sp.setString(saveUserPasswordKey, response.data!.password.toString());
                                             sp.setString(saveUserPassword, password.text.toString());

                                             AppUtil.showToast(response.message!, "s");


                                             Navigator.pushAndRemoveUntil(
                                                 context,
                                                 MaterialPageRoute(builder: (context) =>  Enjoy1()),
                                                 ModalRoute.withName("/enjoy1")

                                             );
                                           }


                                         }
                                       else
                                       {
                                         setState(() {
                                           isLoading=  false;
                                         });
                                       }


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
                                     color: primary,
                                   ),

                                   child:isLoading ? Center(child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: CircularProgressIndicator(color: Colors.white,),
                                   ),): Text("Register",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),),
                                 ),
                               ),

                               SizedBox(height: 15,),

                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("Already have an account?",style: TextStyle(fontSize: 12,color: Color(0xFF454545),fontWeight: FontWeight.bold)),


                                   SizedBox(width: 10,),

                                   InkWell(
                                       onTap: ()
                                       {
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView(),));
                                       },
                                       child: Text("Log in",style: TextStyle(fontSize: 12,color: Color(0xFFe6543a),fontWeight: FontWeight.bold))),
                                 ],
                               ),

                               SizedBox(height: 15,),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),


               /*Column(
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
                             onTap: (){

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
               ),*/



             ),

           ],
         ),
       ),

       /*SafeArea(
         child: Container(
           height: double.infinity,
           width: double.infinity,
           decoration: BoxDecoration(
               image: DecorationImage(
                   fit: BoxFit.fill,
                   image: AssetImage("images/splash.png")
               )
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                 child: IconButton(onPressed: (){
                   _onWillPop();
                 }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
               ),
               Align(
                 alignment: Alignment.bottomCenter,
                 child: Container(

                   width: double.infinity,
                   padding: EdgeInsets.symmetric(horizontal: 35),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                       color: Colors.white
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       SizedBox(height: 33,),
                       Center(
                         child: Text("Register",
                           textAlign: TextAlign.center,
                           style: TextStyle(fontSize: 23,color: primary,fontWeight: FontWeight.bold),),
                       ),
                       SizedBox(height: 15,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                         child: SizedBox(
                           height: 45,
                           child: TextField(

                             controller: fName,
                             keyboardType: TextInputType.text,
                             decoration: InputDecoration(
                               hintText: 'First name',
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
                         padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                         child: SizedBox(
                           height: 45,
                           child: TextField(

                             controller: lName,
                             keyboardType: TextInputType.text,
                             decoration: InputDecoration(
                               hintText: 'Last name',
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
                         padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                         child: SizedBox(
                           height: 45,
                           child: TextField(

                             controller: email,
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
                         padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                         child: SizedBox(
                           height: 45,
                           child: TextField(

                             controller: password,
                             keyboardType: TextInputType.text,
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
                         padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
                         child: SizedBox(
                           height: 45,
                           child: TextField(

                             controller: cnfPassword,
                             keyboardType: TextInputType.text,
                             decoration: InputDecoration(
                               hintText: 'Confirm Password',
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
                       SizedBox(height: 20,),

                       InkWell(
                         onTap: (){

                           if(fName.text.toString().trim().isEmpty)
                             {
                               AppUtil.showToast("Enter first name", "s");
                             }

                           else if(lName.text.toString().trim().isEmpty)
                             {
                               AppUtil.showToast("Enter last name", "s");
                             }

                           else if(email.text.toString().trim().isEmpty)
                             {
                               AppUtil.showToast("Enter email", "s");
                             }

                           else if(password.text.toString().trim().isEmpty)
                             {
                               AppUtil.showToast("Enter password", "s");
                             }

                           else if(cnfPassword.text.toString().trim().isEmpty)
                             {
                               AppUtil.showToast("Re-Enter password", "s");
                             }

                           else if(cnfPassword.text.toString().trim()!=password.text.toString().trim())
                             {
                               AppUtil.showToast("Password not same", "s");
                             }

                           else
                           {
                             RegisterRequestModel requestModel = RegisterRequestModel("", "", "", "", "", "");

                             requestModel.first_name = fName.text.toString().trim();
                             requestModel.last_name = lName.text.toString().trim();
                             requestModel.username = email.text.toString().trim();
                             requestModel.password = password.text.toString().trim();

                             ObjectController controller = ObjectController();

                             setState(() {
                               isLoading=  true;
                             });

                             controller.registerCallAPI(requestModel).then((value) async {

                               RegisterResponse response = value;

                               if(response.error==false && response.data!=null)
                                 {
                                   SharedPreferences sp = await SharedPreferences.getInstance();

                                   sp.setString(saveUserEmail, response.data!.email.toString());
                                   sp.setString(saveUserID, response.data!.id.toString());
                                   sp.setString(saveUserFirst, response.data!.firstName.toString());
                                   sp.setString(saveUserLast, response.data!.lastName.toString());
                                   sp.setString(saveUserStatus, response.data!.status.toString());
                                   sp.setString(saveUserPassword, response.data!.password.toString());

                                   AppUtil.showToast(response.message!, "s");


                                   Navigator.pushAndRemoveUntil(
                                       context,
                                       MaterialPageRoute(builder: (context) =>  Enjoy1()),
                                       ModalRoute.withName("/enjoy1")

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
                             color: primary,
                           ),

                           child:isLoading ? Center(child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: CircularProgressIndicator(color: Colors.white,),
                           ),): Text("Register",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),),
                         ),
                       ),

                       SizedBox(height: 15,),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Already have an account?",style: TextStyle(fontSize: 12,color: Color(0xFF454545),fontWeight: FontWeight.bold)),


                           SizedBox(width: 10,),

                           InkWell(
                               onTap: ()
                               {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView(),));
                               },
                               child: Text("Log in",style: TextStyle(fontSize: 12,color: Color(0xFFe6543a),fontWeight: FontWeight.bold))),
                         ],
                       ),

                       SizedBox(height: 15,),
                     ],
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),*/

     ),
   );
  }
}