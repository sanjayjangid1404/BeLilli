
import 'package:belilli/appcomman/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EnjoyInView.dart';

class ExpiredMember extends StatefulWidget{
  const ExpiredMember({super.key});

  
  @override
  State<StatefulWidget> createState() =>_Enjoy1();
}

class _Enjoy1 extends State<ExpiredMember> {

  String content  = "If you don’t want to continue with Belilli you can cancel at any time in the next 30 days and it will cost you nothing. Zip Nada. If you love being a part of Belilli then the monthly subscription is just £2.99";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: backgroundColor,

          child: Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
            margin: EdgeInsets.only(top: 31,left: 25,right: 25,bottom: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 13,),

                Image.asset("images/enjoy.png",height: 180,fit: BoxFit.contain,),

                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text("Seems like your membership expired",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 23,color: Color(0xFFe6543a),fontWeight: FontWeight.w800),),
                ),

                SizedBox(height: 19,),

                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text("We know you have been part of the Belilli community previously, and we hope you loved exploring the wonderful independent shops and restaurants that define where you live.\n\n",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),

                    Text(" We hope that you signing back into the app means you are ready to re-join our community again, we would love to have you back!",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),



                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EnjoyInView(),));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 17),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: primary,
                          ),

                          child: Text("I’m in!",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),),
                        ),
                      ),
                    ),


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
}