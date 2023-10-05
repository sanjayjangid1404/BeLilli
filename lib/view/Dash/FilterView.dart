
import 'package:belilli/Model/ResponseModel/CategoryListResponse.dart';
import 'package:belilli/appcomman/AppColor.dart';
import 'package:belilli/appcomman/AppUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../appcomman/AppRoute.dart';

class FilterView extends StatefulWidget{
  const FilterView({super.key});


  @override
  State<StatefulWidget> createState() =>_FilterView();
}

class _FilterView extends State<FilterView> {

  double distanceValue = 0;
  var distanceValue2;
  CategoryListResponse categoryNameList = CategoryListResponse();

  List<bool>categoryClick = [];
  List<String>selectCategory = [];





  String fromPage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp){


      // selectCategory = sp.getStringList("filterList")!=null ? sp.getStringList("filterList")!:[];
      
      if(fromPage=="home")
      {

        print("CategoryName=>$categoryNameList");


        for(int i=0; i<categoryNameList.data!.length; i++)
        {
          if(selectCategory.contains(categoryNameList.data![i].id.toString()))

          {
            categoryClick.add(true);
          }
          else
          {
            categoryClick.add(false);
          }
        }

        if(distanceValue2!=null)
          {
            distanceValue = distanceValue2;
          }


      }
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {


    final argument = ModalRoute.of(context)?.settings.arguments as Map;

    fromPage= argument['arg'];

    if(fromPage=="home" && argument["data"]!=null)
      {
        categoryNameList = argument['data'];
        if(argument["type"]!=null)
          {
            selectCategory = argument["type"];
          }
        if(argument["value"]!=null)
          {
            distanceValue2 = double.parse(argument["value"].toString());
          }

      }


    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(

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

                      Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Center(
                          child: Text("Filters",
                            style: TextStyle(fontSize: 18,color: Colors.white),),
                        ),
                      ),


                    ],
                  ),
                ),

                SizedBox(height: 29,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text("Your location",style: TextStyle(fontSize: 12,color: Colors.white),),
                      ),

                      SizedBox(height: 0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10),
                        child: SizedBox(
                          height: 35,
                          child: TextField(

                            // controller: searchCtrl,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 13,color: greyColor),
                            decoration: InputDecoration(
                              hintText: 'Location',
                              hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.w800,color: Color(0xFF454545)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                borderSide: BorderSide(color: Color(0xFFdbd3f4), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                borderSide: BorderSide(color: Color(0xFFdbd3f4), width: 1),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green,width: 0.4),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                              fillColor: Color(0xFFF8F9FA),
                            ),
                          ),
                        ),
                      ),


                      SizedBox(height: 35,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text("Search radius",style: TextStyle(fontSize: 12,color: Colors.white),),
                      ),

                      SizedBox(height: 20,),

                      Slider(
                        value: distanceValue,
                        min: 0,
                        max: 5,
                        divisions: 100,
                        activeColor: Color(0xFF4B40F0),
                        thumbColor: redColor,
                        inactiveColor: Colors.white,
                        // label: distanceValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            distanceValue = value;
                          });
                        },
                      ),

                      Center(child: Text(distanceValue.round().toString()+" miles",
                        style: TextStyle(fontSize: 15,color: Colors.white),)),

                      SizedBox(height: 30,),

                      Divider(
                        color: Colors.white,
                        height: 1,
                      ),

                      SizedBox(height: 20,),

                      categoryClick.isNotEmpty ?
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          for (int i=0; i<categoryNameList.data!.length;i++)
                            InkWell(
                              onTap: (){
                               setState(() {
                                 if(categoryClick[i])
                                 {
                                   categoryClick[i]=false;
                                 }
                                 else
                                 {
                                   categoryClick[i] = true;
                                 }
                               });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                                  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                      color: categoryClick[i]? Color(0xFFe6543a) :Colors.transparent,

                                      border: Border.all(color:categoryClick[i]? Color(0xFFe6543a) : Colors.white,width: 1)),
                                  child: Text(categoryNameList.data![i].name.toString(),style: TextStyle(fontSize: 12,color: Colors.white),)),
                            ),
                        ],
                      ) : SizedBox(),

                      SizedBox(height: 30,),

                      Center(
                        child: InkWell(
                          onTap: ()
                          {
                            setState(() {
                              categoryClick.clear();
                              distanceValue = 0;
                              for(int i=0; i<categoryNameList.data!.length; i++)
                              {
                                categoryClick.add(false);
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color:Color(0xFFe6543a),width: 1 )
                            ),

                            child: Text("Clear all filters",style: TextStyle(fontSize: 12,color: Colors.white),),
                          ),
                        ),
                      ),

                      SizedBox(height: 40,),

                      InkWell(
                        onTap: ()
                         async {

                          List<String>selectCategory = [];


                          for(int i=0; i<categoryClick.length; i++)
                          {
                            if(categoryClick[i])
                            {
                              selectCategory.add(categoryNameList.data![i].id.toString());
                            }
                          }

                        if(selectCategory.isNotEmpty || distanceValue>0)
                          {
                            NavigationService.instance.navigateToArgVal("/searchFilterHome", distanceValue.toString(), selectCategory);
                          }
                        else {
                          AppUtil.showToast("Apply Filter", "i");
                        }


                          setState(()  {
                            print(selectCategory);
                          });

                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: Border.all(color:Colors.white,width: 1 )
                          ),

                          child: Text("Save filters",style: TextStyle(fontSize: 18,color: primary),),
                        ),
                      ),


                    ],
                  ),
                ),








              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterData{

  String? categoryId;
}