
import 'package:belilli/appcomman/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../appcomman/AppRoute.dart';

class AccountDetailsView extends StatefulWidget{
  const AccountDetailsView({super.key});


  @override
  State<StatefulWidget> createState() =>_AccountDetailsView();
}

class _AccountDetailsView extends State<AccountDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: backgroundColor,
          child: Column(
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
                        child: Text("Account",
                          style: TextStyle(fontSize: 18,color: Colors.white),),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 23,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 22),
                margin: EdgeInsets.symmetric(horizontal: 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Your current subscription:\n£2.99/month",
                      style: TextStyle(fontSize: 19,color: redColor),),
                    SizedBox(height: 27,),

                    InkWell(
                      onTap: (){
                        NavigationService.instance.navigateTo("/cancelSubscription");
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 11),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primary
                        ),
                        child: Text("Cancel Subscription",style: TextStyle(fontSize: 16,color: Colors.white),),
                      ),
                    ),



                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}