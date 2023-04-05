
import 'package:belilli/appcomman/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../window/LoginView.dart';
import '../window/RegisterView.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});


  @override
  State<StatefulWidget> createState() =>_SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,

          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("images/splash.png")
            )
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [


                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return LoginView();
                    },));


                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),

                    child: Text("Log In",style: TextStyle(fontSize: 18,color: Color(0xFF4d40fa),fontWeight: FontWeight.w800),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return RegisterView();
                    },));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFe6543a),
                    ),

                    child: Text("Register",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w800),),
                  ),
                ),
                SizedBox(height: 80,)



              ],
            ),
          ),
        ),
      ),
    );
  }
}