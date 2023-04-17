
import 'dart:async';

import 'package:belilli/appcomman/AppColor.dart';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'EnjoyInView.dart';

class Enjoy1 extends StatefulWidget{
  const Enjoy1({super.key});

  
  @override
  State<StatefulWidget> createState() =>_Enjoy1();
}

class _Enjoy1 extends State<Enjoy1> {


   String testID = 'book_test';
  final InAppPurchase _iap = InAppPurchase.instance;

   bool _isAvailable = false;

  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  late StreamSubscription _subscription;

  int _credits = 0;


  Future<void> _getUserProducts() async {
    Set<String> ids = {testID};
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
    });
  }


  void _buyProduct(ProductDetails prod){
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }

  void _verifyPurchases(){
    PurchaseDetails purchase = _hasUserPurchased(testID);
    if(purchase != null && purchase.status == PurchaseStatus.purchased){
      _credits = 10;
    }
  }

  PurchaseDetails _hasUserPurchased(String productID){
    return _purchases.firstWhere((purchase) => purchase.productID == productID);
  }

  @override
  void dispose() {

    // cancelling the subscription
    _subscription.cancel();

    super.dispose();
  }



  String content  = "If you don’t want to continue with Belilli you can cancel at any time in the next 30 days and it will cost you nothing. Zip Nada. If you love being a part of Belilli then the monthly subscription is just £2.99";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: primary,
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
                  child: Text("You’re nearly there… we’re so excited to have you join us",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 23,color: Color(0xFFe6543a),fontWeight: FontWeight.w800),),
                ),

                SizedBox(height: 19,),

                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text("Come and experience the Belilli community. We know you are going to love exploring the wonderful independent shops and restaurants that define where you live. The places that are the heart and soul of the place you call home.\n\n",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12.5,color: Color(0xFF454545)),),

                    Text.rich(
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
                          TextSpan(text: '  and it will cost you nothing. Zip Nada. If you love being a part of Belilli then the monthly subscription is just £2.99',
                              style: TextStyle(fontSize: 12.5,color: Color(0xFF454545))),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () async {

                          // _buyProduct(_products[0]);
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

                    SizedBox(height: 3,),

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