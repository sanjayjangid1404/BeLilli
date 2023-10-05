
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:belilli/Model/RequestModel/SubscriptionRequest.dart';
import 'package:belilli/api/ObjectController.dart';
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

 import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ResponseModel/SubscriptionResponse.dart';
import '../appcomman/AppVariable.dart';
import 'EnjoyInView.dart';


class Enjoy1 extends StatefulWidget{

  const Enjoy1({super.key});


  @override
  State<StatefulWidget> createState() =>_Enjoy1();
}

class _Enjoy1 extends State<Enjoy1> {

  // var _variant = {"one_month_subscription_create"};
  var _variant = {"one_month_subscription"};

  String userId = "";
  String password = "";
  bool isLoading = false;

  List<ProductDetails> _products = [];
  InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<dynamic> _streamSubscription;



  @override
  void dispose() {

    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp) {
      userId = sp.getString(saveUserID)!=null ? sp.getString(saveUserID)! : "";
      password = sp.getString(saveUserPasswordKey)!=null ? sp.getString(saveUserPasswordKey)! : "0";
      Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
      _streamSubscription = purchaseUpdated.listen((purchaseList) {
        _listenToPurchase(purchaseList, context);
      }, onDone: (){
        _streamSubscription.cancel();
      }, onError: (error){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error1")));
      });
      initStore();

      setState(() {

      });
    });




  }


  _listenToPurchase(List<PurchaseDetails> purchaseDetailsList, BuildContext context) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pending")));
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        AppUtil.appLogs(purchaseDetails.verificationData.localVerificationData.toString());
        AppUtil.appLogs(purchaseDetails.verificationData.serverVerificationData.toString());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error")));
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        // AppUtil.showToast(purchaseDetails.verificationData.serverVerificationData.toString(),"i");
        AppUtil.appLogs(purchaseDetails.verificationData.localVerificationData.toString());
        AppUtil.appLogs(purchaseDetails.verificationData.serverVerificationData.toString());
        AppUtil.appLogs(purchaseDetails);
        // showCustomDialog(context,purchaseDetails.verificationData.serverVerificationData.toString());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Purchased")));

        setState(() {
          isLoading = true;
        });

        SubscriptionRequest request = SubscriptionRequest(userId, Platform.isAndroid ? "Android" : "IOS", DateTime.now().toString(),
            "paid", password, purchaseDetails.verificationData.localVerificationData.toString());

        ObjectController controller = ObjectController();

        controller.updateSubscriptionAPI(request).then((value){

          SubscriptionResponse response = value;

          if(!response.error! && response.data!=null)
            {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>  EnjoyInView()),
                  ModalRoute.withName("/enjoy1")

              );

            }

          setState(() {
            isLoading = false;
          });
        });

      }
    });
  }

  _buy(){
    final PurchaseParam param = PurchaseParam(productDetails: _products[0]);

    print(param.productDetails.price);
    print(param.productDetails.rawPrice);
    // print(param.productDetails.);
    _inAppPurchase.buyNonConsumable(purchaseParam: param);
  }

  void showCustomDialog(BuildContext context, String jsonData) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            title: Center(child: Text("Information")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: 500,
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      jsonData.toString(),
                    )
                  ],
                ),
              ),
            ),

          );
        });
  }

  initStore() async{
    ProductDetailsResponse productDetailsResponse =
    await _inAppPurchase.queryProductDetails(_variant);
    if(productDetailsResponse.error==null){
      setState(() {

        print(productDetailsResponse.productDetails[0].title);
        _products = productDetailsResponse.productDetails;
      });
    }
  }







  String content  = "If you don’t want to continue with Belilli you can cancel at any time in the next 30 days and it will cost you nothing. Zip Nada. If you love being a part of Belilli then the monthly subscription is just £2.99";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: primary,
              child: Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                margin: const EdgeInsets.only(top: 31,left: 25,right: 25,bottom: 100),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 13,),

                      Image.asset("images/enjoy.png",height: 180,fit: BoxFit.contain,),

                      const SizedBox(height: 15,),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text("You’re nearly there… we’re so excited to have you join us",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 23,color: Color(0xFFe6543a),fontWeight: FontWeight.w800),),
                      ),

                      const SizedBox(height: 19,),

                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Text("Come and experience the Belilli community. We know you are going to love exploring the wonderful independent shops and restaurants that define where you live. The places that are the heart and soul of the place you call home.\n\n",
                              textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),

                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'For the next ',style: TextStyle(fontSize: 12.5,color: Color(0xFF454545))),

                                  TextSpan(text: '30 days, you can join Belilli for free',style: TextStyle(fontSize: 12.5,color: Color(0xFF4B40F1))),
                                  TextSpan(text: '  See where you discover and see what you can save. Tell a friend, and another. Let’s build a community that really loves the unique places that define it.\n\n',
                                      style: TextStyle(fontSize: 12.5,color: Color(0xFF454545))),
                                ],
                              ),
                            ),

                             Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'If you don’t want to continue with Belilli you can ',style: TextStyle(fontSize: 12.5,color: Color(0xFF454545))),

                                  TextSpan(text: 'cancel at any time in the next 30 days',style: TextStyle(fontSize: 12.5,color: Color(0xFF4B40F1))),
                                  TextSpan(text: '  and it will cost you nothing. Zip Nada. If you love being a part of Belilli then the monthly subscription is just  £ 2.99',
                                      style: TextStyle(fontSize: 12.5,color: Color(0xFF454545))),
                                  //${_products!=null && _products[0]!=null ? _products[0].price : "£ 2.99"}
                                ],
                              ),
                            ),

                            _products!=null && _products.isNotEmpty ?
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () async {

                                  _buy();







                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => EnjoyInView(),));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 17),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: primary,
                                  ),

                                  child: const Text("I’m in!",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),),
                                ),
                              ),
                            ) : SizedBox(),

                            const SizedBox(height: 3,),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            isLoading ?Container(
                color: loadBackgroundColor.withOpacity(0.7),
                width: double.infinity,
                height: double.infinity,
                child: SpinKitCircle(
                  color: loaderColor,
                  size: 70.0,
                  duration: Duration(milliseconds: 1200),
                ))
                : Stack()
          ],
        ),
      ),
    );
  }





}
