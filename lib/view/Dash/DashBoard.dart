import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/RequestModel/AddFavouriteRequest.dart';
import '../../Model/ResponseModel/RedeemOfferResponse.dart';
import '../../api/ObjectController.dart';
import '../../appcomman/AppFont.dart';
import '../../appcomman/AppRoute.dart';
import 'ActivityView.dart';
import 'FavouriteView.dart';
import 'HomeView.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoard createState() =>_DashBoard();
}

class _DashBoard extends State<DashBoard> {

  int _selectedIndex = 0;
  int selectPosition = 0;
  String _counter = "0";

  String _scanBarcode = '';
  bool isAdding = false;
  ScrollController controller =  ScrollController();



  bool isDataFetching = false;

   List<Widget> _widgetOptions = [HomeView(),FavouriteView(),
     HomeView(),ActivityView()];

   String userID = "";
   List<Widget> sideBarOption = [];
  // late final ScrollListener _model;
  void _onItemTapped(int index) {
    setState(() {


      _selectedIndex = index;

      if(_selectedIndex==2)
        {
          barcodeScan();
        }
      // getAllCartList();
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  DashBoard()),
        ModalRoute.withName("/dash")

    );
    return true; //
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    SharedPreferences.getInstance().then((SharedPreferences sp) {

      userID = sp.getString(saveUserID)!=null ? sp.getString(saveUserID)! : "";

      // getAllWishList(userID);



      setState(() {});

    });
  }
  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;

      print(_scanBarcode);

      if(_scanBarcode!="-1")
        {
          getOffer(_scanBarcode);
        }


      _selectedIndex =0;
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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Center(
            child:
            _widgetOptions.elementAt(_selectedIndex),
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
      bottomNavigationBar: Container(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
                canvasColor: Colors.white,

                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Colors.white,
               ),
            child: BottomNavigationBar(
              onTap: _onItemTapped,
              fixedColor: primary,

              type: BottomNavigationBarType.fixed,
              selectedIconTheme: IconThemeData(color: primary),
              currentIndex: _selectedIndex,
              selectedLabelStyle:  TextStyle(color: primary,fontSize: 10
                  ,fontFamily: primaryFont),
              unselectedLabelStyle:  TextStyle(color: primary,fontSize: 10,fontFamily: primaryFont),
              items:   <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("images/home.png"),size: 22,),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("images/heart.png"),size: 22,),
                  label: 'Favourite',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("images/barcode.png"),size: 22,),

                  label: 'Redeem',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("images/activity.png"),size: 22,),
                  label: 'Activity',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}