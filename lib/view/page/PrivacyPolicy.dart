
import 'package:belilli/appcomman/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../appcomman/AppRoute.dart';

class PrivacyPolicy extends StatefulWidget{
  const PrivacyPolicy({super.key});


  @override
  State<StatefulWidget> createState() =>_PrivacyPolicy();
}

class _PrivacyPolicy extends State<PrivacyPolicy> {
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
                          child: Text("Privacy",
                            style: TextStyle(fontSize: 18,color: Colors.white),),
                        ),
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 23,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Privacy",
                        style: TextStyle(fontSize: 21,color: Colors.white),),
                      SizedBox(height: 16,),
                      
                      Text("Lorem ipsum dolor sit amet consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.\n""fLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no",
                        style: TextStyle(fontSize: 14,color: Colors.white),)
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