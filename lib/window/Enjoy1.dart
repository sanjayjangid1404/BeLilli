
import 'dart:async';
import 'dart:io';

import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ConsumableStore.dart';
import 'EnjoyInView.dart';

class Enjoy1 extends StatefulWidget{
  const Enjoy1({super.key});


  @override
  State<StatefulWidget> createState() =>_Enjoy1();
}

class _Enjoy1 extends State<Enjoy1> {


  String testID = 'android.test.purchased';
  List<String> testID2 = ['android.test.purchased'];
  final InAppPurchase _iap = InAppPurchase.instance;

  bool _isAvailable = false;

  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];


  int _credits = 0;

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];

  List<String> _consumables = <String>[];

  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

   bool _kAutoConsume = true;

   String _kConsumableId = 'android.test.purchased';
   // String _kUpgradeId = 'upgrade';
   // String _kSilverSubscriptionId = 'subscription_silver';
   // String _kGoldSubscriptionId = 'subscription_gold';
   List<String> _kProductIds = [];


  Future<void> _getUserProducts() async {
    Set<String> ids = {testID};
    if(await _iap.isAvailable()){
      ProductDetailsResponse response = await _iap.queryProductDetails(ids);

      print(response.productDetails);

      if(response.productDetails!=null)
      {
        _products = response.productDetails;
       /* for(int i=0; i<response.productDetails.length; i++)
        {
          _products.add(response.productDetails[i]);
        }*/
      }

      print(_products);
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: _products[0]);
      _iap.buyConsumable(purchaseParam: purchaseParam);


    }
    else {
      AppUtil.showToast("Something wrong", "i");
    }


    setState(() {
      // _products = response.productDetails;
    });
  }


  final Set<String> _kIds = {'android.test.purchased'};





  Future<void> _startPurchase(ProductDetails productDetails1) async {
    final ProductDetails productDetails = productDetails1;
     PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    if (await InAppPurchase.instance.isAvailable()) {
      await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);


    } else {
      // In-app purchases are not available.
    }
  }




  @override
  void dispose() {

    // cancelling the subscription
    _subscription.cancel();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp) {
      _getUserProducts();
      setState(() {

      });
    });
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

                        const Text.rich(
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

                              if(_products.isNotEmpty)
                                {
                                  print("erwefrqgwtyg"+_products[0].title);
                                  _startPurchase(_products[0]);
                                }
                              else
                              {
                                AppUtil.showToast("No Subscription found", "i");
                              }





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
                        ),

                        const SizedBox(height: 3,),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
