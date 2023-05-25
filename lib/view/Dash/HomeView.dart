
import 'dart:async';
import 'dart:math';

import 'package:belilli/Model/RequestModel/BusinessFilterRequest.dart';
import 'package:belilli/Model/ResponseModel/SearchResponse.dart';
import 'package:belilli/api/ArrayController.dart';
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppFont.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/RequestModel/AddFavouriteRequest.dart';
import '../../Model/RequestModel/RemoveFavRequest.dart';
import '../../Model/RequestModel/SearchItemFavRequest.dart';
import '../../Model/ResponseModel/BusinessResponse.dart';
import '../../Model/ResponseModel/CategoryListResponse.dart';
import '../../Model/ResponseModel/FeaturedListResponse.dart';
import '../../Model/ResponseModel/SimpleResponse.dart';
import '../../api/ApiURL.dart';
import '../../api/ObjectController.dart';
import '../../appcomman/AppRoute.dart';
import '../../skeleton_widgets/skeleton_view.dart';

class HomeView extends StatefulWidget{
  const HomeView({super.key});


  @override
  State<StatefulWidget> createState()=>_HomeView();
}

class _HomeView extends State<HomeView> {

  CategoryListResponse categoryListResponse = CategoryListResponse();
  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchNode = FocusNode();
  String userID = "";
  String userLat = "0";
  String userLon = "0";
  String userRadius = "0";
  double position  = 0;
  List<bool>favItemValue = [];
  BusinessResponse businessResponse = BusinessResponse();
  FeaturedListResponse featuredListResponse = FeaturedListResponse();
  bool isLoading = false;
  bool isDataLoading = false;
  bool isUserLocation = false;
  bool isAdding = false;
  bool isFeaturing = false;
  bool isDataNotFound = false;
  bool isCategoryFound = true;
  SearchResponse response = SearchResponse();
  // on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];


  List<String>selectCategory = [];

  List<String>categoryName =[];
  List<String>categoryId =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp){
      userID = sp.getString(saveUserID)!=null ? sp.getString(saveUserID)! : "";
      userLon = sp.getString(saveUserLon)!=null ? sp.getString(saveUserLon)! : "0";
      userLat = sp.getString(saveUserLat)!=null ? sp.getString(saveUserLat)! : "0";
      userRadius = sp.getString("radius")!=null ? sp.getString("radius")! : "0";
      isUserLocation = sp.getBool(userLocationBool)!=null ? sp.getBool(userLocationBool)! : false;
      selectCategory = sp.getStringList("filterList")!=null ? sp.getStringList("filterList")!:[];

      if(isUserLocation)
        {
          getUserCurrentLocation().then((value) async {

            SharedPreferences sp = await SharedPreferences.getInstance();

            sp.setString(saveUserLat, value.latitude.toString());
            sp.setString(saveUserLon, value.longitude.toString());

            userLat = value.latitude.toString();
            userLon = value.longitude.toString();
            getAllCategory();


            print(value);
          });
        }
      else
      {
        getAllCategory();
      }

      FocusManager.instance.primaryFocus?.unfocus();

      setState(() {
      });

    });
  }
  getBusiness(String searchValue,String categoryID,String userRadius)
  {

    setState(() {
      isDataLoading=  true;
    });
    ArrayController controller = ArrayController();
    BusinessFilterRequest request = BusinessFilterRequest("", "", "", "", "", "","");
    request.category_ids = categoryID;
    request.userId = userID;
    request.radius = userRadius;
    request.longitude = userLon;
    request.latitude = userLat;
    request.search_key = searchValue;
    controller.getAllBusiness(request).then((value) {

      businessResponse = value!;

      if(businessResponse.data!=null && businessResponse.error==false)
        {

          getFeaturedData(searchValue, categoryID);

          if(businessResponse.data!.length>5) {
            position =5;
          }
          else
          {
            position = businessResponse.data!.length/2;
          }

          for(int i=0; i<businessResponse.data!.length; i++)
            {
              if(businessResponse.data![i].memberFavourite.toString() =="1")
                {
                  favItemValue.add(true);
                }
              else
              {
                favItemValue.add(false);
              }
            }


          setState(() {
            isDataNotFound = false;
          });

        }
      else
      {
        setState(() {
          isDataNotFound = true;
        });
      }

      setState(() {
        isDataLoading=  false;
      });

      print(isDataNotFound);


    });
  }

  getFeaturedData(String searchValue,String categoryID)
  {

    setState(() {
      isFeaturing=  true;
    });
    ArrayController controller = ArrayController();
    BusinessFilterRequest request = BusinessFilterRequest("", "", "", "", "", "","");
    request.category_ids = categoryID;
    // request.userId = userID;
    request.search_key = searchValue;
    controller.getAllFeatured(request).then((value) {

      featuredListResponse = value!;

      if(featuredListResponse.data!=null && featuredListResponse.error==false)
        {

        }
      else
      {

      }

      setState(() {
        isFeaturing=  false;
      });
    });
  }

  void getAllCategory()
  {
    ArrayController controller = ArrayController();

    setState(() {
      isLoading=  true;
    });

    controller.getAllCategory().then((value){

      categoryListResponse = value!;

      if(categoryListResponse.error==false && categoryListResponse.data!=null)
        {

          setState(() {
            isCategoryFound = false;
          });
          for(int i=0; i<categoryListResponse.data!.length; i++)
            {
              categoryName.add(categoryListResponse.data![i].name.toString());
              categoryId.add(categoryListResponse.data![i].id.toString());
            }

          getBusiness("",selectCategory.join(","),userRadius);

        }

      else
      {
        setState(() {
          isCategoryFound=  true;
        });
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
             RefreshIndicator(

               onRefresh: () {

                return _refreshBusiness(context);

               },
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     headBar(),
                   isLoading || isDataLoading ?
                       Center(child: CircularProgressIndicator(color: Colors.white,),):
                   businessResponse.data!=null && businessResponse.data!.isNotEmpty?
                   Column(
                     children: [
                       selectCategory.isEmpty ? isLoading ?SkeletonView(height: 120,) :categoryWidget():SizedBox(),
                       SizedBox(height: searchCtrl.text.isEmpty ? 35 : 10,),

                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 17.0),
                         child: Row(
                           children: [
                             Text(searchCtrl.text.isEmpty ? "Awesome places near me" : "Search results",style: TextStyle(fontSize: 18,color: Colors.white),),
                             SizedBox(width: 10,),
                             Visibility(
                               visible: searchCtrl.text.isEmpty ? true : false,
                               child: Container(
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                                 padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                 child: Text("TN1",style: TextStyle(fontSize: 15,color: Color(0xFFD34D35)),),
                               ),
                             )
                           ],
                         ),
                       ),
                       productList(),
                     ],
                   ) :isDataNotFound ?  Column(
                     children: [
                       SizedBox(height: 67,),
                       notHaveService()
                     ],
                   ) : Center(child: CircularProgressIndicator(color: Colors.white,),),

                   ],
                 ),
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

  Widget headBar()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 28),
      child: Row(

        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
              child: SizedBox(
                height: 40,
                child: TypeAheadField(
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),

                  ),suggestionsBoxVerticalOffset: 0,

                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      controller: searchCtrl,
                      focusNode: searchNode,
                      onChanged: (value){
                        setState(() {
                          if(value.length>2) {
                            getAllSearchResult(value);
                          }
                          else {
                            if(response.data!=null) {
                              response.data!.clear();
                            }
                          }
                        });
                      },
                    onSubmitted: (value){
                        setState(() {
                          getBusiness(value,selectCategory.join(","),userRadius);
                        });
                    },
                      style: AppUtil.textStyle(),
                    decoration: InputDecoration(

                      hintText: 'Help me find…',
                      prefixIcon: Icon(Icons.search,color: Color(0xFF9A9A9A),size: 25,),
                      hintStyle: TextStyle(fontSize: 14,fontFamily:primaryFont,color: Color(0xFF454545)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFFdbd3f4), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: response.data != null  && response.data!.length>0 ? BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)) : BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFFdbd3f4), width: 1),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                      fillColor: Color(0xFFF8F9FA),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return List.generate(getSearchData(response).length, (index) {
                      return {'name': getSearchData(response)[index]};
                    });
                  },
                  noItemsFoundBuilder: (context){
                    return SizedBox();
                  },
                  itemBuilder: (context, suggestion) {
                    return   Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      child: Text(suggestion['name']!,style: TextStyle(fontSize: 12,color: Colors.black),),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                   setState(() {
                     searchCtrl.text = suggestion['name']!;
                     getBusiness(suggestion['name']!,selectCategory.join(","),userRadius);
                   });
                  },
                )
              ),
            ),
          ),

          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 10,),
              InkWell(
                  onTap: (){
                    if(categoryListResponse.data!=null)
                    {
                      NavigationService.instance.navigateToArgValueVal("/filterView","home",categoryListResponse,null);
                    }
                    else
                    {
                      AppUtil.showToast("Please wait...", "i");
                    }
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppUtil.fullWidth(context)*0.01),
                    child: ImageIcon(AssetImage("images/filter.png"),size: 27,color: Color(0xFFe6543a),),
                  )),
              SizedBox(width: 10,),
              InkWell(
                  onTap: (){
                    NavigationService.instance.navigateTo("/accountView");
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppUtil.fullWidth(context)*0.01),
                    child: ImageIcon(AssetImage("images/profile.png"),size: 27,color: Color(0xFFe6543a),),
                  ))
            ],
          ))
        ],
      ),
    );
  }

  Widget categoryWidget()
  {

    return searchCtrl.text.isEmpty ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Padding(
          padding: EdgeInsets.only(left: 17,bottom: 10),
          child: Text("I am in the mood for…",
            style: TextStyle(fontSize: 18,fontFamily: primaryFont,color: Colors.white),),
        ),
        Container(
          height: 120,
          padding: EdgeInsets.only(left: 17),

          child:
          ListView.builder(
            itemCount: categoryListResponse.data!=null ?categoryListResponse.data!.length : 0,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap:(){
                    List<String>selectCategory = [];

                    selectCategory.add(categoryListResponse.data![index].id.toString());
                    NavigationService.instance.navigateToArgVal("/searchFilterHome", "0", selectCategory);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 7,bottom: 7),
                    child: Container(
                      height: 90,
                      width: 90,

                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),

                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: imageURL+categoryListResponse.data![index].banner.toString(),
                            fit: BoxFit.fill,
                            height:150,
                            width: double.infinity,

                            placeholder: (context, url) => SkeletonView(),
                            errorWidget: (context, url, error) => Center(
                              child: Center(child: Icon(Icons.error)),
                            ),
                            fadeOutDuration: Duration(
                              seconds: 2,
                            ),
                          ),

                        /*Image.asset("images/image2.png",height: 90,width: 90,fit: BoxFit.cover,)*/),
                    ),
                  ),
                ),

                Text(categoryListResponse.data![index].name.toString(),
                  style: TextStyle(fontSize: 10,fontFamily: primaryFont,color: Colors.white),),
              ],
            );
          },),
        ),

      ],
    ) : SizedBox();
  }

  Widget productList()
  {
    return ListView.builder(
      itemCount: businessResponse.data!=null ? businessResponse.data!.length : 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 12),
            child: Column(
              children: [
                InkWell(
                  onTap: ()
                  {
                    NavigationService.instance.navigateToArgVal("/productDetails","product",businessResponse.data![index].id.toString());
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                          child:CachedNetworkImage(
                            imageUrl: imageURL+businessResponse.data![index].image.toString(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(

                            padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(businessResponse.data![index].categoryName.toString(),
                              style: TextStyle(fontSize: 10,color: Colors.red),),
                          ),
                          favItemValue[index] ?
                          InkWell(
                            onTap: (){
                              removeFav(businessResponse.data![index].id.toString(),index);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                              child: ImageIcon(AssetImage("images/heart.png"),size: 27,color: Color(0xFFe6543a),),
                            ),
                          ):
                          InkWell(
                            onTap: (){
                              addFavourite(businessResponse.data![index].id.toString(),index);

                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                              child: ImageIcon(AssetImage("images/blankheart.png"),size: 27,color: Color(0xFFe6543a),),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
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
                                Text(businessResponse.data![index].businessName.toString(),
                                  style: TextStyle(fontSize: 12,color: greyColor),),
                                SizedBox(height: 6,),
                                Text(businessResponse.data![index].offerTitle.toString(),style: TextStyle(fontSize: 11,color: redColor),),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text(double.parse(businessResponse.data![index].distance.toString()).toStringAsFixed(1)+" miles",
                                  style: TextStyle(fontSize: 12,color: greyColor),)))
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),

          Visibility(
              visible: int.parse(position.toStringAsFixed(0))== index+1 ? true : false,
              child:!isFeaturing && featuredListResponse.data!.isNotEmpty ? featuredContainer()
            : SizedBox())
        ],
      );
    },);
  }

  AddFavouriteRequest addFavouriteRequest = AddFavouriteRequest("","");

  void addFavourite(String businessId,int index)
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

        setState(() {
          favItemValue[index]= true;
        });
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

  void removeFav(String id,int index)
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


        setState(() {
          favItemValue[index]= false;
        });
      }
      else
      {
        AppUtil.showToast(response.message!, "e");
      }
    });
  }

  Widget featuredContainer()
  {
    return Container(
      color: Colors.white,
      width: double.infinity,

      padding: EdgeInsets.only(left: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          Text("Featured businesses",style: TextStyle(fontSize: 14,color: greyColor),),
          SizedBox(height: 11,),
          !isFeaturing ? SizedBox(
            height: 200,
            width: double.infinity,
          child: ListView.builder(
            itemCount: featuredListResponse.data!=null ? featuredListResponse.data!.length : 0,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
            return SizedBox(
                width:247,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap:(){
                    NavigationService.instance.navigateToArgVal("/productDetails","product",featuredListResponse.data![index].id.toString());
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                          child: CachedNetworkImage(
                            imageUrl: imageURL+featuredListResponse.data![index].image.toString(),
                            fit: BoxFit.fill,
                            height: 140,
                            width: 247,
                            placeholder: (context, url) => SkeletonView(),
                            errorWidget: (context, url, error) => Center(
                              child: Center(child: Icon(Icons.error)),
                            ),
                            fadeOutDuration: Duration(
                              seconds: 2,
                            ),
                          )),
                      Container(
                        decoration:BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffDDDDDD),
                              blurRadius: 6.0,
                              spreadRadius: 1.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],

                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex:1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(featuredListResponse.data![index].businessName.toString(),
                                      maxLines:1,
                                      overflow:TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12,color: greyColor),),
                                    SizedBox(height: 6,),
                                    Text(featuredListResponse.data![index].categoryName.toString(),style: TextStyle(fontSize: 11,color: redColor),),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex:1,
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text("1.2 miles away",style: TextStyle(fontSize: 12,color: greyColor),)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },),
          ) : SkeletonView(height: 200,)


        ],
      ),
    );
  }


  String getCategoryName(String id)
  {
    String name = "";

    for(int i=0; i<categoryId.length; i++)
      {
        if(id==categoryId[i])
          {
            name = categoryName[i];
          }
      }

    return name;
  }


  Widget notHaveService()
  {
    return Center(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,

        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 22,),

            Image.asset("images/feeling.png",
              height: 308,fit: BoxFit.contain,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Text("Sorry we are not in your area yet",
                style: TextStyle(fontSize: 18,color: redColor),),

            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Text("You can find us at SW34",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15,color: greyColor),),
            ),

            SizedBox(height: 50,)
          ],
        ),

      ),
    );
  }

  void getAllSearchResult(String value)
  {

    ObjectController controller = ObjectController();
    SearchItemFavRequest requestModel = SearchItemFavRequest(value);
    controller.searchQueryItem(requestModel).then((value){
      response = value;
      if(!response.error!)
        {
          getSearchData(response);
        }
      
    });
  }
  List<String>getSearchData(SearchResponse response)
  {
    List<String>data = [];

    if(response.data!=null)
      {
        for(int i=0; i<response.data!.length; i++)
        {
          data.add(response.data![i]);
        }
      }
    

    return data;
  }


  String getDistance(String lat,String lon)
  {

    String distance = "";

    distance = (Geolocator.distanceBetween(double.parse(userLat), double.parse(userLon),
        double.parse(lat), double.parse(lon))/1000).toStringAsFixed(0)+"KM";
    return distance;
  }

  Future<void> _refreshBusiness(BuildContext context) async {
    return getAllCategory();
  }
}






