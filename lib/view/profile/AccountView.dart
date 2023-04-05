
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppFont.dart';
import 'package:belilli/appcomman/AppRoute.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../appcomman/AppUtil.dart';
import '../../window/LoginView.dart';
import '../Dash/DashBoard.dart';

class AccountView extends StatefulWidget{
  const AccountView({super.key});


  @override
  State<StatefulWidget> createState() =>_AccountView();
}

class _AccountView extends State<AccountView> {

  String userID = "";
  String userLName = "";
  String userFName = "";

  Future<bool> _onWillPop() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  const DashBoard()),
        ModalRoute.withName("/dash")

    );
    return true; //
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop();
      },
      child: Scaffold(
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
                          icon: const Icon(Icons.arrow_back,color: Colors.white,),
                          onPressed: (){
                            _onWillPop();
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                          child: Text("Hi there ${"$userFName $userLName"}",
                            style: const TextStyle(fontSize: 18,color: Colors.white),),
                        ),
                      ),


                    ],
                  ),
                ),
                const SizedBox(height: 46,),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      accountDetails("Personal details"),
                      accountDetails("Account"),
                      accountDetails("Settings"),
                      accountDetails("Privacy / terms"),
                      InkWell(
                        onTap: (){
                          confirmDialog(context);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFDAD3F1),width: 1)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 16),
                          child: Text("Log out",style: TextStyle(fontSize: 15,color: primary),),
                        ),
                      )
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp){

      userID=  sp.getString(saveUserID)!=null? sp.getString(saveUserID)!:"";

      userLName = sp.getString(saveUserLast)!=null ? sp.getString(saveUserLast)! : "";
      userFName = sp.getString(saveUserFirst)!=null ? sp.getString(saveUserFirst)! : "";
      setState(() {

      });


    });
  }

  Widget accountDetails(String title)
  {
    return InkWell(
      onTap: ()
      {
        if(title.toLowerCase()=="personal details")
          {
            NavigationService.instance.navigateTo("/profileView");

          }
        else if(title.toLowerCase()=="account")
          {
            NavigationService.instance.navigateTo("/accountDetails");
          }
        else if(title.toLowerCase()=="settings")
          {
            NavigationService.instance.navigateTo("/settings");

          }
        else
        {
          NavigationService.instance.navigateTo("/privacyPolicy");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDAD3F1),width: 1)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(fontSize: 13,color: greyColor),),
            Icon(Icons.arrow_forward_ios_rounded,color: redColor,size: 15,)
          ],
        ),
      ),
    );
  }


  void confirmDialog(BuildContext context)
  {

    // set up the buttons
    Widget cancelButton = TextButton(
      child:  Text("Cancel",style: TextStyle(color: primary),),
      onPressed:  () {
        Navigator.of(context).pop();

      },
    );

    Widget continueButton =InkWell(
      onTap: (){
        Navigator.pop(context);
        _logoutUser();
      },
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: primary),
          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
          margin: const EdgeInsets.only(right: 15),
          child:  const Text("Logout",style: TextStyle(color: Colors.white,fontFamily: primaryFont),
          )
      ),);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: const Text("Logout!", style: TextStyle(fontSize: 16),),
      content: const Text("Confirm, you want to logout from the app?",
        style: TextStyle(fontSize: 14,fontFamily: primaryFont),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _logoutUser() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.clear();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  const LoginView()),
        ModalRoute.withName("/login")
    );
    setState(() {

    });
    AppUtil.showToast('Logout Successfully','s');
  }
}