
import 'package:belilli/Model/RequestModel/ProfileUpdateRequest.dart';
import 'package:belilli/api/ObjectController.dart';
import 'package:belilli/appcomman/AppRoute.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/RequestModel/ForgetPassword.dart';
import '../../Model/ResponseModel/SimpleResponse.dart';
import '../../appcomman/AppColor.dart';

class ProfileView extends StatefulWidget{
  const ProfileView({super.key});


  @override
  State<StatefulWidget> createState() =>_ProfileView();
}

class _ProfileView extends State<ProfileView> {

  String userFName = "";
  String userLName = "";
  String userID = "";
  String userPassword = "";
  String userEmail = "";
  bool isLoading   = false;
  bool isUpdate   = false;


  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp){

      userEmail = sp.getString(saveUserEmail)!=null ? sp.getString(saveUserEmail)! : "";
      userID = sp.getString(saveUserID)!=null ? sp.getString(saveUserID)! : "";
      userLName = sp.getString(saveUserLast)!=null ? sp.getString(saveUserLast)! : "";
      userFName = sp.getString(saveUserFirst)!=null ? sp.getString(saveUserFirst)! : "";
      userPassword = sp.getString(saveUserPassword)!=null ? sp.getString(saveUserPassword)! : "";


      email = TextEditingController(text: userEmail);
      fName = TextEditingController(text: userFName);
      lName = TextEditingController(text: userLName);
      // password = TextEditingController(text: userPassword);

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
          child: SingleChildScrollView(
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
                          child: Text("Personal details",
                            style: TextStyle(fontSize: 18,color: Colors.white),),
                        ),
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 39,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Text("First Name*",style: TextStyle(fontSize: 12,color: Colors.white),),
                                  ),
                                  SizedBox(height: 0,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextField(

                                        controller: fName,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(fontSize: 13,color: greyColor),
                                        decoration: InputDecoration(
                                          hintText: 'First Name',
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
                                          contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                                          fillColor: Color(0xFFF8F9FA),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            flex:1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Text("Last Name*",style: TextStyle(fontSize: 12,color: Colors.white),),
                                  ),
                                  SizedBox(height: 0,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextField(

                                        controller: lName,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(fontSize: 13,color: greyColor),
                                        decoration: InputDecoration(
                                          hintText: 'Last Name',
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
                                          contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                                          fillColor: Color(0xFFF8F9FA),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 30,),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text("Email*",style: TextStyle(fontSize: 12,color: Colors.white),),
                      ),
                      SizedBox(height: 0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
                        child: SizedBox(
                          height: 35,
                          child: TextField(

                            controller: email,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 13,color: greyColor),
                            decoration: InputDecoration(
                              hintText: 'katie.fisher@gmail.com',
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
                              contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                              fillColor: Color(0xFFF8F9FA),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      InkWell(
                        onTap: (){





                            if(fName.text.toString().trim().isEmpty )
                            {
                              AppUtil.showToast("Enter first name","e");
                            }
                            else if(lName.text.toString().trim().isEmpty )
                            {
                              AppUtil.showToast("Enter last name","e");
                            }
                            else if(fName.text.toString().trim() ==userFName && lName.text.toString().trim()==userLName)
                              {
                                AppUtil.showToast("Already Updated", "i");
                              }
                            else {

                              ProfileUpdateRequest requestModel1 = ProfileUpdateRequest("", '', "");

                              requestModel1.lName = lName.text.toString();
                              requestModel1.fName = fName.text.toString();
                              requestModel1.username = userID;

                              setState(() {
                                isUpdate=  true;
                              });

                              ObjectController controller = ObjectController();
                              controller.updateProfile(requestModel1).then((value) async {

                                SimpleResponse response = value;

                                if(response.error==false)
                                {

                                  SharedPreferences sp = await SharedPreferences.getInstance();

                                  sp.setString(saveUserFirst, fName.text.toString().trim());
                                  sp.setString(saveUserLast, lName.text.toString().trim());
                                  AppUtil.showToast(response.message!, "s");
                                  Navigator.pop(context);
                                  NavigationService.instance.navigatePopAndPushNamed("/accountView");

                                }


                                setState(() {
                                  isUpdate=  false;
                                });
                              });

                          }

                        },
                        child: Container(

                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: isUpdate ? Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(color: Colors.white,),
                          ),):
                          Text("Update Profile",style: TextStyle(fontSize: 14,color: Colors.white),),
                        ),
                      ),



                      SizedBox(height: 45.5,),

                      Divider(color: Colors.white,height: 1,),

                      SizedBox(height: 27,),

                      resetPassword(),

                      SizedBox(height: 40,),
                      
                      InkWell(
                        onTap: (){

                          if(newPassword.text.toString().trim().isNotEmpty)
                            {
                              if(newPassword.text.toString().trim().isEmpty)
                              {
                                AppUtil.showToast("Enter password", "e");
                              }
                              else if(password.text.toString().trim().isEmpty)
                              {
                                AppUtil.showToast("Re-Enter password", "e");
                              }

                              else if(password.text.toString().trim()!=newPassword.text.toString().trim())
                              {
                                AppUtil.showToast("Password not match", "e");
                              }

                              else
                              {


                                ForgetPassword requestModel = ForgetPassword("", "");

                                requestModel.password = newPassword.text.toString().trim();
                                requestModel.username = userID;



                                setState(() {
                                  isLoading = true;
                                });

                                ObjectController controller = ObjectController();

                                controller.forgetPassword(requestModel).then((value) async {

                                  SimpleResponse response = value;

                                  if(response.error==false)
                                  {

                                    SharedPreferences sp = await SharedPreferences.getInstance();

                                    sp.setString(userPassword, newPassword.text.toString().trim());

                                    AppUtil.showToast(response.message!, "s");
                                    Navigator.pop(context);
                                    NavigationService.instance.navigatePopAndPushNamed("/accountView");

                                  }
                                  else
                                  {
                                    AppUtil.showToast(response.message!, "e");
                                  }

                                  setState(() {
                                    isLoading = false;
                                  });
                                });

                              }
                            }


                        },
                        child: Container(

                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: isLoading ? Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(color: Colors.white,),
                          ),):
                          Text("Update",style: TextStyle(fontSize: 14,color: Colors.white),),
                        ),
                      ),

                      SizedBox(height: 40,)



                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget resetPassword()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text("Reset password",style: TextStyle(fontSize: 15,color: Colors.white),),
        SizedBox(height: 27,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text("New password*",style: TextStyle(fontSize: 12,color: Colors.white),),
        ),
        SizedBox(height: 0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
          child: SizedBox(
            height: 35,
            child: TextField(

              controller: newPassword,
              keyboardType: TextInputType.text,
              obscureText: true,
              obscuringCharacter: "*",
              style: TextStyle(fontSize: 13,color: greyColor),
              decoration: InputDecoration(
                hintText: 'New Password',
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
                contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                fillColor: Color(0xFFF8F9FA),
              ),
            ),
          ),
        ),

        SizedBox(height: 35,),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Text("Confirm Password*",style: TextStyle(fontSize: 12,color: Colors.white),),
        ),
        SizedBox(height: 0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
          child: SizedBox(
            height: 35,
            child: TextField(

              controller: password,
              obscureText: true,
              obscuringCharacter: "*",
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 13,color: greyColor),
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
                contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                fillColor: Color(0xFFF8F9FA),
              ),
            ),
          ),
        ),
      ],
    );
  }
}