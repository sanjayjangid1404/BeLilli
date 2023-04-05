
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../appcomman/AppColor.dart';
import '../view/Dash/DashBoard.dart';

class EnjoyInView extends StatefulWidget{
  const EnjoyInView({super.key});


  @override
  State<StatefulWidget> createState() =>_EnjoyInView();
}

class _EnjoyInView extends State<EnjoyInView> {
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
                  SizedBox(height: 43,),
                  Center(
                    child: Text("You are in!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 23,color: Color(0xFF4d40fa),fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 19,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text("Welcome to the Belilli community. Love your local, independent shops and restaurants and they will love you back. So do we. You are awesome.\n\n",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),
                  ),





                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  DashBoard()),
                          ModalRoute.withName("/dashBoard")

                      );
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

                      child: Text("Let me explore rewards",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),),
                    ),
                  ),

                  SizedBox(height: 41,),





                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}