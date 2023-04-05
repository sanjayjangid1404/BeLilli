
import 'package:belilli/api/ArrayController.dart';
import 'package:belilli/api/ObjectController.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/RequestModel/SimpleRequest.dart';
import '../../Model/ResponseModel/GetActivityResponse.dart';
import '../../appcomman/AppColor.dart';
import '../../appcomman/AppRoute.dart';

class ActivityView extends StatefulWidget{
  const ActivityView({super.key});


  @override
  State<StatefulWidget> createState() =>_ActivityView();
}

class _ActivityView extends State<ActivityView> {

  String userID = "";
  bool isLoading  = false;
  bool isFound  = true;
  GetActivityResponse response = GetActivityResponse();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp){

      userID = sp.getString(saveUserID)!=null ? sp.getString(saveUserID)!:"";

      getActivity();
      setState(() {

      });


    });
  }

  void getActivity()
  {
    ArrayController controller = ArrayController();
    SimpleRequest request = SimpleRequest("");

    request.userID = userID;

    setState(() {
      isLoading=  true;
    });

    controller.getAllActivity(request).then((value) {

      response = value!;

      if(response.error==false && response.data==null)
        {
          setState(() {
            isFound = false;
          });
        }
      else
      {
        setState(() {
          isFound = true;
        });
      }
      setState(() {
        isLoading=  false;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Activity",style: TextStyle(fontSize: 18,color: Colors.white),),
                      InkWell(
                          onTap: (){
                            NavigationService.instance.navigateTo("/accountView");
                          },
                          child: ImageIcon(AssetImage("images/profile.png"),size: 27,color: Color(0xFFe6543a),))
                    ],
                  ),
                  SizedBox(height: 16,),

                 isLoading ? Center( child: CircularProgressIndicator(color: Colors.white,),) :
                 isFound ?  activityContainer() : AppUtil.notHaveService("Sorry Not Found Activity", "Please redeem offer"),
                  SizedBox(height: 16,),

                  // productList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget activityContainer()
  {
    return ListView.builder(
      itemCount:response.data!=null ?  response.data!.acitivity!.length :0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
          child: Row(
            children: [
              Expanded(
                  flex:1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(response.data!.acitivity![index].businessName.toString(),style: TextStyle(fontSize: 12,color: greyColor),),
                      SizedBox(height: 6,),
                      Text(response.data!.acitivity![index].offerName.toString(),style: TextStyle(fontSize: 11,color: redColor),),
                    ],
                  )),
              Expanded(
                flex:1,
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(AppUtil.changeDateFormat(response.data!.acitivity![index].redeemDate.toString(), "yyyy-MM-dd", "MMM dd,yy"),style: TextStyle(fontSize: 12,color: greyColor),)),
              )
            ],
          ),
        ),
      );
    },);
  }
}