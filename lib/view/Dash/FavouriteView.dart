

import 'package:belilli/Model/RequestModel/RemoveFavRequest.dart';
import 'package:belilli/Model/ResponseModel/FavouriteResponse.dart';
import 'package:belilli/Model/ResponseModel/SimpleResponse.dart';
import 'package:belilli/api/ArrayController.dart';
import 'package:belilli/api/ObjectController.dart';
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppRoute.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/RequestModel/FavListRequest.dart';
import '../../api/ApiURL.dart';
import '../../skeleton_widgets/skeleton_view.dart';
import '../Dialog.dart';

class FavouriteView extends StatefulWidget{
  const FavouriteView({super.key});


  @override
  State<StatefulWidget> createState() =>_FavouriteView();
}

class _FavouriteView extends State<FavouriteView> {

  FavouriteResponse responseList = FavouriteResponse();

  String userId = "";
  String userLat = "";
  String userLon = "";
  bool isLoading = true;
  bool isDelete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((sp){

      userId = sp.getString(saveUserID)!=null ? sp.getString(saveUserID)! : "";



      getUserCurrentLocation().then((value) async {

        SharedPreferences sp = await SharedPreferences.getInstance();

        sp.setString(saveUserLat, value.latitude.toString());
        sp.setString(saveUserLon, value.longitude.toString());

        userLat = value.latitude.toString();
        userLon = value.longitude.toString();

        getAllFavList();

        setState(() {

        });


        print(value);
      });

      setState(() {

      });


    });
  }

  void getAllFavList()
  {
    ArrayController controller = ArrayController();

    setState(() {
      isLoading=  true;
    });

    FavListRequest requestModel  = FavListRequest("","","");
    requestModel.latitude = userLat;
    requestModel.longitude = userLon;
    requestModel.userId = userId;

    controller.getAllFavouriteList(requestModel).then((value){


      responseList = value!;

      if(responseList.error == true)
        {
          AppUtil.showToast(responseList.message!, "i");
        }

      setState(() {
        isLoading=  false;
      });
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(

          height: double.infinity,
          width: double.infinity,
          color: backgroundColor,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Places I love",style: TextStyle(fontSize: 18,color: Colors.white),),
                          InkWell(
                              onTap: (){
                                NavigationService.instance.navigateTo("/accountView");
                              },
                              child: ImageIcon(AssetImage("images/profile.png"),size: 27,color: Color(0xFFe6543a),))
                        ],
                      ),
                      SizedBox(height: 6,),

                     isLoading  ? Center(child: CircularProgressIndicator(color: Colors.white,),)  : productList()
                    ],
                  ),
                ),
              ),


              isDelete ?Container(
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

  Widget productList()
  {
    return ListView.builder(
      itemCount: responseList.data!=null ? responseList.data!.length : 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 8),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                      child: CachedNetworkImage(
                        imageUrl: imageURL+responseList.data![index].image.toString(),
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
                  Container(

                    padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(responseList.data![index].categoryName.toString(),
                      style: TextStyle(fontSize: 10,color: Colors.red),),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)
                    ),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                          flex:1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(responseList.data![index].businessName.toString(),style: TextStyle(fontSize: 12,color: greyColor),),
                              SizedBox(height: 6,),
                              Text("10% off hot drinks",style: TextStyle(fontSize: 11,color: redColor),),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                  onTap: (){

                                    showDialog(
                                      barrierColor: Colors.black26,
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                          title: "Business Removed",
                                          description: "The Business has been removed from your Favourites list.",
                                            onTap: () { removeFav(responseList.data![index].businessId.toString()); }

                                        );
                                      },
                                    );

                                  },
                                  child: ImageIcon(AssetImage("images/heart.png"),size: 27,color: Color(0xFFe6543a),)),))
                    ],
                  ),
                ),
              ),

            ],
          ),
        );
      },);
  }


  void removeFav(String id)
  {
    ObjectController controller = ObjectController();


    setState(() {
      isDelete = true;
    });

    RemoveFavRequest requestModel = RemoveFavRequest("", "");

    requestModel.userID  = userId;
    requestModel.businessId  = id;

    controller.removeBusinessFev(requestModel).then((value){

      SimpleResponse response = value;

      setState(() {
        isDelete = false;
      });

      if(response.error==false)
        {
          AppUtil.showToast(response.message!, "s");
          getAllFavList();

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