
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
  List<String> testID2 = ['belilli_2.99_1m'];
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

   String _kConsumableId = 'consumable';
   String _kUpgradeId = 'upgrade';
   String _kSilverSubscriptionId = 'subscription_silver';
   String _kGoldSubscriptionId = 'subscription_gold';
   List<String> _kProductIds = [];


  Future<void> _getUserProducts() async {
    Set<String> ids = {testID};
    if(await _iap.isAvailable()){
      ProductDetailsResponse response = await _iap.queryProductDetails(ids);

      print(response.productDetails);

      if(response.productDetails!=null)
      {
        for(int i=0; i<response.productDetails.length; i++)
        {
          _products.add(response.productDetails[i]);
        }
      }

      print(_products);


    }
    else {
      AppUtil.showToast("Something wrong", "i");
    }


    setState(() {
      // _products = response.productDetails;
    });
  }


  final Set<String> _kIds = {'android.test.purchased'};

  Future<void> _loadProducts() async {
    final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(_kIds);

    print(response.productDetails);
    if (response.notFoundIDs.isNotEmpty) {
      for(int i=0; i<response.productDetails.length; i++)
      {
        _products.add(response.productDetails[i]);
      }
      // Handle any unavailable product IDs.
    }
    // Use response.productDetails to access the product details.
  }


  void _buyProduct(ProductDetails prod){
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }

  Future<void> _startPurchase(String productId) async {
    final ProductDetails productDetails = _products[0];
     PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    if (await InAppPurchase.instance.isAvailable()) {
      await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      // In-app purchases are not available.
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp) {

    /*  _kProductIds = [_kConsumableId,
        _kUpgradeId,
        _kSilverSubscriptionId,
        _kGoldSubscriptionId,];

      final Stream<List<PurchaseDetails>> purchaseUpdated =
          _iap.purchaseStream;
      _subscription =
          purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
            _listenToPurchaseUpdated(purchaseDetailsList);
          }, onDone: () {
            _subscription.cancel();
          }, onError: (Object error) {
            // handle error here.
          });
      initStoreInfo();*/

      _getUserProducts();
      _loadProducts();
      setState(() {

      });
    });
  }

  /*Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            _iap.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _iap.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }*/




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

                            /*late PurchaseParam purchaseParam;

                            final Map<String, PurchaseDetails> purchases =
                            Map<String, PurchaseDetails>.fromEntries(
                                _purchases.map((PurchaseDetails purchase) {
                                  if (purchase.pendingCompletePurchase) {
                                    _iap.completePurchase(purchase);
                                  }
                                  return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
                                }));

                            if (Platform.isAndroid) {
                              // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                              // verify the latest status of you your subscription by using server side receipt validation
                              // and update the UI accordingly. The subscription purchase status shown
                              // inside the app may not be accurate.
                              final GooglePlayPurchaseDetails? oldSubscription =
                              _getOldSubscription(_products[0], purchases);

                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: _products[0],
                                  applicationUserName: null,
                                  changeSubscriptionParam: (oldSubscription != null)
                                      ? ChangeSubscriptionParam(
                                    oldPurchaseDetails: oldSubscription,
                                    prorationMode:
                                    ProrationMode.immediateWithTimeProration,
                                  )
                                      : null);
                            } else {
                              purchaseParam = PurchaseParam(
                                productDetails: _products[0],
                                applicationUserName: null,
                              );
                            }*/
                            // const Set<String> _kIds = {'belilli_2.99_1m'};
                            // final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(_kIds);
                            //
                            // print(response.notFoundIDs);
                            // if (response.notFoundIDs.isEmpty) {
                            //
                            //   AppUtil.showToast("Something wrong", "i");
                            //   // Handle the error.
                            // } else {
                            //   List<ProductDetails> products = response.productDetails;
                            //   for (ProductDetails product in products) {
                            //     print('${product.title}: ${product.description} (cost is ${product.price})');
                            //   }
                            //   // Example: purchasing the first available item.
                            //   final PurchaseParam purchaseParam = PurchaseParam(productDetails: products[0]);
                            //   InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
                            // }

                            // _buyProduct(_products[0]);
                            _startPurchase(_products[0].id.toString());
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

/*  Future<void> initStoreInfo() async {
    final bool isAvailable = await _iap.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _iap
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
    await _iap.queryProductDetails(testID2.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == _kSilverSubscriptionId &&
        purchases[_kGoldSubscriptionId] != null) {
      oldSubscription =
      purchases[_kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == _kGoldSubscriptionId &&
        purchases[_kSilverSubscriptionId] != null) {
      oldSubscription =
      purchases[_kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }*/




}
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}