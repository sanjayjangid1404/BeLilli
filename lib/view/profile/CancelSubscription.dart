
import 'package:belilli/appcomman/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CancelSubscription extends StatefulWidget{
  const CancelSubscription({super.key});

  
  @override
  State<StatefulWidget> createState() =>_CancelSubscription();
}

class _CancelSubscription extends State<CancelSubscription> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.only(top: 31,left: 25,right: 25,bottom: 80),
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),

              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 13,),

                    Image.asset("images/cancel.png",height: 180,fit: BoxFit.contain,),

                    SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text("Oh no! We don’t want to lose you.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 23,color: Color(0xFFe6543a),fontWeight: FontWeight.w800),),
                    ),

                    SizedBox(height: 19,),

                    Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text("We’re really sorry that you want to cancel your subscription to Belilli.\n\n",
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),


                        Text("As a member of the Belilli community you have access to rewards and offers at a number of your local independent shops and restaurants, the places that truly define where you live. \n\n",
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),

                        Text("These places are awesome and for the people that own them, their lives and livelihoods. We really want to connect you with them.\n\n",
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),

                        Text("We know times are tough, but for the approximate price of a cup of coffee each month you can access savings across your community as well as support the places that make it special.\n\n",
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),




                        Text("To continue, the cost will be:\n £2.99/month.\n\n",
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: primary),),

                        Text("But if you have to leave us, we will miss you. You can come back any time…\n\n",
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),



                        InkWell(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => EnjoyInView(),));
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

                            child: Text("Confirm cancellation",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),),
                          ),
                        ),

                        SizedBox(height: 3,),

                      ],
                    ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(height: 80,),
    );
  }
}