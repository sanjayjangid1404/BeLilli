import 'dart:io';

import 'package:belilli/Model/ResponseModel/FavouriteResponse.dart';
import 'package:belilli/api/ApiURL.dart';
import 'package:belilli/api/ObjectController.dart';
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model/RequestModel/AddFavouriteRequest.dart';
import '../../Model/RequestModel/BusinessDetailsRequest.dart';
import '../../Model/RequestModel/RemoveFavRequest.dart';
import '../../Model/RequestModel/SimpleRequest.dart';
import '../../Model/ResponseModel/BusinessDetailsResponse.dart';
import '../../Model/ResponseModel/RedeemOfferResponse.dart';
import '../../Model/ResponseModel/SimpleResponse.dart';
import '../../api/ArrayController.dart';
import '../../appcomman/AppRoute.dart';
import '../../skeleton_widgets/skeleton_view.dart';
import '../Dialog.dart';

class ProductDetails extends StatefulWidget{
  const ProductDetails({super.key});


  @override
  State<StatefulWidget> createState() =>_ProductDetails();
}

class _ProductDetails extends State<ProductDetails> {

  String _scanBarcode = "";
  String userID = "";
  bool isLoading  =false;
  bool isAdding  =false;

  List<String>favIds = [];
  BusinessDetailsResponse businessDetailsResponse = BusinessDetailsResponse();
  String fromPage = "";
  BusinessDetailsRequest requestModel = BusinessDetailsRequest("");
  var id;

  String categoryName = "";
  String distance = "";
  String businessName = "";
  String businessId = "";
  String images = "";
  String offer = "";
  String offerDetails = "";
  String details = "";
  String lnt = "";
  String lng = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp){

      userID = sp.getString(saveUserID)!=null?sp.getString(saveUserID)! : "";

      if(fromPage=="product" && id!=null)
        {
          getBusinessData();
        }

      // getAllFavList();
      setState(() {

      });

    });
  }

  void getBusinessData()
  {

    setState(() {
      isLoading = true;
    });
    requestModel.businessID = id;

    ObjectController controller = ObjectController();

    controller.businessDetailsAPI(requestModel).then((value){

      businessDetailsResponse = value;

      if(businessDetailsResponse.error==false && businessDetailsResponse.data!=null)
        {


          categoryName = businessDetailsResponse.data!.categoryName.toString();
          businessName = businessDetailsResponse.data!.businessName.toString();
          businessId = businessDetailsResponse.data!.id.toString();
          offer = businessDetailsResponse.data!.offerTitle.toString();
          offerDetails = businessDetailsResponse.data!.offerTerms.toString();
          details = businessDetailsResponse.data!.description.toString();
          lnt = businessDetailsResponse.data!.lat.toString();
          lng = businessDetailsResponse.data!.lng.toString();
          images = imageURL+businessDetailsResponse.data!.image.toString();
          distance = "${businessDetailsResponse.data!.distance} miles";
        }

      setState(() {
        isLoading = false;
      });
    });

  }

/*  void getAllFavList()
  {
    ArrayController controller = ArrayController();

    setState(() {
      isLoading=  true;
    });

    SimpleRequest requestModel  = SimpleRequest(userID);

    controller.getAllFavouriteList(requestModel).then((value){


     FavouriteResponse responseList = value!;
     favIds.clear();

      if(responseList.error == false && responseList.data!=null)
      {
       for(int i=0; i<responseList.data!.length; i++)
         {
           favIds.add(responseList.data![i].businessId.toString());
         }
      }

      setState(() {
        isLoading=  false;
      });
    });
  }*/
  @override
  Widget build(BuildContext context) {

    final argument = ModalRoute.of(context)?.settings.arguments as Map;

    fromPage = argument["arg"];

    if(fromPage=="product")
      {
        id = argument["data"];
      }
   return Scaffold(

     body: SafeArea(
       child: Container(
         height: double.infinity,
         width: double.infinity,
         color: backgroundColor,
         child:Stack(
           children: [
             isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,),) :
             SingleChildScrollView(
               child: Column(
                 children: [

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                       children: [
                         Padding(
                           padding: const EdgeInsets.only(top: 6.0),
                           child: IconButton(
                             icon: Icon(Icons.arrow_back,color: Colors.white,),
                             onPressed: (){
                               Navigator.pop(context);
                               NavigationService.instance.navigatePopAndPushNamed("/dashBoard");
                             },
                           ),
                         ),

                         Row(
                           children: [
                             Container(
                               padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(6),
                                 color: Colors.white
                               ),
                               child: Text(categoryName,style: TextStyle(fontSize: 12,color: redColor),),
                             ),
                             Container(
                               padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                               margin: EdgeInsets.symmetric(horizontal: 6),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(6),
                                 color: Colors.white
                               ),
                               child: Text(distance,style: TextStyle(fontSize: 12,color: primary),),
                             )
                           ],
                         )

                       ],
                     ),
                   ),
                   SizedBox(height: 10,),

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 17.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           margin: const EdgeInsets.only(bottom: 0.0),

                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.only(
                                   topRight: Radius.circular(12),
                                   topLeft: Radius.circular(12)
                               ),
                               color: Colors.white
                           ),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                             child: Row(
                               children: [
                                 Expanded(
                                     flex:3,
                                     child: Text(businessName,style: TextStyle(fontSize: 16,color: greyColor),)),
                                 Expanded(
                                     flex: 1,
                                     child: InkWell(
                                       onTap: ()
                                       {
                                         if(fromPage=="product" && !favIds.contains(businessId))
                                           {
                                             addFavourite();

                                           }
                                         else
                                         {
                                           showDialog(
                                             barrierColor: Colors.black26,
                                             context: context,
                                             builder: (context) {
                                               return CustomAlertDialog(
                                                 title: "Business Removed",
                                                 description: "The Business has been removed from your Favourites list.",
                                                 onTap: () { removeFav(businessId); },

                                               );
                                             },
                                           );

                                         }
                                       },
                                       child: Align(
                                         alignment: Alignment.topRight,
                                         child: favIds.contains(businessId) ? ImageIcon(AssetImage("images/heart.png"),size: 27,color: Color(0xFFe6543a),) :
                                         ImageIcon(AssetImage("images/blankheart.png"),size: 27,color: Color(0xFFe6543a),),),
                                     ))
                               ],
                             ),
                           ),
                         ),
                         ClipRRect(
                             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                             child: CachedNetworkImage(
                               imageUrl: images,
                               fit: BoxFit.fill,
                               height:143,
                               width: double.infinity,

                               placeholder: (context, url) => SkeletonView(),
                               errorWidget: (context, url, error) => Center(
                                 child: Center(child: Icon(Icons.error)),
                               ),
                               fadeOutDuration: Duration(
                                 seconds: 2,
                               ),
                             )),


                       ],
                     ),
                   ),

                   SizedBox(height: 40,),
                   Padding(
                       padding: EdgeInsets.symmetric(horizontal: 17),
                     child:  Container(
                       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 22),

                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12),
                         color: Colors.white,
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Text(offer,
                             style: TextStyle(fontSize: 19,color: redColor,letterSpacing: 0.08),),
                           SizedBox(height: 20,),

                           Text(offerDetails,

                             style: TextStyle(fontSize: 12,color: Color(0xFF121212),letterSpacing: 0.04),),

                           SizedBox(
                             height: 16,
                           ),

                           InkWell(
                             onTap: (){

                               // getOffer("2");
                               barcodeScan();

                               // NavigationService.instance.navigateTo("/cancelSubscription");
                             },
                             child: Container(
                               width: double.infinity,
                               alignment: Alignment.center,
                               padding: EdgeInsets.symmetric(vertical: 11),

                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                                   color: primary
                               ),
                               child: Text("Get Offer",style: TextStyle(fontSize: 16,color: Colors.white),),
                             ),
                           ),



                         ],
                       ),
                     ),

                   ),

                   SizedBox(height: 36,),

                   Container(
                     width: double.infinity,
                     padding: EdgeInsets.symmetric(horizontal: 13),
                     margin: EdgeInsets.symmetric(horizontal: 17),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(color: Colors.white,width: 1)),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: 16,),
                         Text(businessName,
                           style: TextStyle(fontSize: 16,color: Colors.white,letterSpacing: 0.06),),

                         SizedBox(height: 10,),

                         Text(details,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         style: TextStyle(fontSize: 12,color: Colors.white,letterSpacing: 0.04),
                         ),

                         SizedBox(height: 10,),

                         InkWell(
                           onTap: (){
                             openMap(double.parse(lnt), double.parse(lng));
                           },
                           child: Container(
                             width: double.infinity,
                             alignment: Alignment.center,
                             padding: EdgeInsets.symmetric(vertical: 8),

                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(9),
                                 color: redColor
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(Icons.location_on,color: Colors.white,size: 18,),
                                 SizedBox(width: 3,),
                                 Text("Find on map",style: TextStyle(fontSize: 12,color: Colors.white,letterSpacing: 0.04),),
                               ],
                             ),
                           ),
                         ),

                         SizedBox(height: 19,)
                       ],
                     ),
                   )



                 ],
               ),
             ),

             isAdding ?Container(
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
     ),
   );
  }


  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
      // AppUtil.showToast(barcodeScanRes, "i");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;

      print( "deferferf"+barcodeScanRes);

      if(_scanBarcode.isNotEmpty && _scanBarcode!="-1")
        {
          getOffer(_scanBarcode.toString());
        }

    });
  }

  void getOffer(String id)
  {

    setState(() {
      isAdding = true;
    });
    AddFavouriteRequest addFavouriteRequest = AddFavouriteRequest("","");
    addFavouriteRequest.userID = userID;
    addFavouriteRequest.businessID = id;

    ObjectController controller = ObjectController();
    controller.redeemOffer(addFavouriteRequest).then((value){

      RedeemOfferResponse response = value;

      if(response.error==false && response.data!=null)
        {
          NavigationService.instance.navigateToArgVal("/takeOfferView",_scanBarcode.toString(),response.data);
        }

      setState(() {
        isAdding = false;
      });
    });


  }


  AddFavouriteRequest addFavouriteRequest = AddFavouriteRequest("","");

  void addFavourite()
  {

    setState(() {
      isAdding = true;
    });

    addFavouriteRequest.userID = userID;
    addFavouriteRequest.businessID = businessId;
    ObjectController controller = ObjectController();
    controller.addBusinessFev(addFavouriteRequest).then((value){
      SimpleResponse response = value;

      if(response.error ==false)
        {
          AppUtil.showToast(response.message!, "s");
          // getAllFavList();
        }
      else
      {
        AppUtil.showToast(response.message!, "e");
      }

      setState(() {
        isAdding = false;
      });

    });
  }

  Future<void> openMap(double latitude, double longitude) async {
    String mapUrl = '';
    if (Platform.isIOS) {
      mapUrl =
      'https://maps.apple.com/?daddr=$latitude,$longitude';
    } else {
      mapUrl =
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';
    }

    if (await canLaunchUrl(Uri.parse(mapUrl))) {
      await launchUrl(Uri.parse(mapUrl),mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }


  void removeFav(String id)
  {
    ObjectController controller = ObjectController();


    setState(() {
      isAdding = true;
    });

    RemoveFavRequest requestModel = RemoveFavRequest("", "");

    requestModel.userID  = userID;
    requestModel.businessId  = id;

    controller.removeBusinessFev(requestModel).then((value){

      SimpleResponse response = value;

      setState(() {
        isAdding = false;
      });

      if(response.error==false)
      {
        AppUtil.showToast(response.message!, "s");
        // getAllFavList();

        setState(() {

        });
      }
      else
      {
        AppUtil.showToast(response.message!, "e");
      }
    });
  }
}