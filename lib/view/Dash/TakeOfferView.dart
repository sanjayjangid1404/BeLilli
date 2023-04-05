
import 'package:belilli/Model/ResponseModel/RedeemOfferResponse.dart';
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../appcomman/AppRoute.dart';
import 'DashBoard.dart';

class TakeOfferView extends StatefulWidget{
  const TakeOfferView({super.key});


  @override
  State<StatefulWidget> createState()=>_TakeOfferView();
}

class _TakeOfferView extends State<TakeOfferView>{



  String fromPage = "";
  bool isVisible = false;

  Data data = Data();



  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    NavigationService.instance.navigatePopAndPushNamed("/dashBoard");
    return true; //
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp){

      setState(() {
        isVisible = true;
      });

      Future.delayed(Duration(seconds: 3), (){
        print("Wait for 10 seconds");

        setState(() {
          isVisible = false;
        });
      });


    });
  }
  @override
  Widget build(BuildContext context) {

    final argument = ModalRoute.of(context)?.settings.arguments as Map;
    fromPage  = argument["arg"];
    if(argument["data"]!=null) {
      data  = argument["data"];

      print(data);

    }
    return WillPopScope(
      onWillPop:_onWillPop,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,

          decoration: BoxDecoration(
              color: backgroundColor,

          ),


          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 64,),
                Container(

                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 19),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    color: Colors.white

                  ),

                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Image.asset("images/getoffer.png",height: 334,),

                          SizedBox(height: 22,),

                          Text("Thank you for supporting your local community and redeeming your reward from "
                              "(${data.businessName.toString()}), you are awesome!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13,color: greyColor),),

                          SizedBox(height: 22,),

                          InkWell(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  DashBoard()),
                                  ModalRoute.withName("/dashBoard")

                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 35,vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: redColor
                              ),
                              child: Text("Find more rewards",style: TextStyle(fontSize: 12,color: Colors.white),),
                            ),
                          ),

                          SizedBox(height: 40,),

                        ],
                      ),
                      Visibility(
                        // visible: isVisible,
                        child: Center(child: Image.asset("images/image3.gif",

                          fit: BoxFit.fill,width: double.infinity,)),
                      )
                    ],
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}