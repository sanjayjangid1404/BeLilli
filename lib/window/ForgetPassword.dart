
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../appcomman/AppColor.dart';

class ForgetPassword extends StatefulWidget{
  const ForgetPassword({super.key});


  @override
  State<StatefulWidget> createState() =>_ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword> {
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
                 SizedBox(height: 44,),
                 Center(
                   child: Text("Forgot password",
                     textAlign: TextAlign.center,
                     style: TextStyle(fontSize: 23,color: Color(0xFF4d40fa),fontWeight: FontWeight.bold),),
                 ),
                 SizedBox(height: 22,),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                   child: Text("It looks like you forgot your password. Bravo! This probably means you take digital security seriously. We can fix this…\n\n",
                     textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),
                 ),


                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
                   child: SizedBox(
                     height: 45,
                     child: TextField(

                       // controller: searchCtrl,
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



                 SizedBox(height: 10,),


                 Container(
                   width: double.infinity,
                   height: 40,
                   alignment: Alignment.center,
                   margin: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(12),
                     color: primary,
                   ),

                   child: Text("Recover password",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),),
                 ),

                 SizedBox(height: 82,),





               ],
             ),
           ),
         ),
       ),
     ),
   );
  }
}