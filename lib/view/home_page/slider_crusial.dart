import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gyros_app/view/home_page/home_page_controller.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

//import 'package:http/http.dart' as http;

class MySlider extends StatelessWidget {
  final _sliderKey = GlobalKey();
  MySlider({Key? key}) : super(key: key);
  HomePageController _homePageController = Get.put(HomePageController());

  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  final List<String> images = [
    'lib/assets/asset/ghee5.jpeg',
    'lib/assets/asset/oil_1.jpeg',
    'lib/assets/asset/honey2.jpeg',
    'lib/assets/asset/gaggery4.jpeg',
    'lib/assets/asset/spice1.jpeg',
    'lib/assets/asset/sattu6.jpeg',
    'lib/assets/asset/sweet3.jpeg',
    'lib/assets/asset/dal4.jpeg',
  ];
  final bool _isPlaying = true;

  // get _sliderKey => null;

  @override
  Widget build(BuildContext context) {
    var base = 'https://api.gyros.farm/Images/';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => (_homePageController.isLoading.value)
            ? Center(child: CircularProgressIndicator())
            // : _homePageController.getsliderbaner!.bannerImageList == null
            //     ? Center(
            //         child: Text('No data'),
            //       )
                : SizedBox(
                    height: 27.h,
                    child: CarouselSlider.builder(
                      key: _sliderKey,
                      unlimitedMode: true,
                      autoSliderTransitionTime: Duration(seconds: 4),
                      autoSliderDelay:Duration(seconds: 4),
                      // autoSliderTransitionTime =  Duration(seconds: 2),
                      slideBuilder: (index) {
                        return Container(
                          height: 26.h,
                          alignment: Alignment.center,
                          child: Container(
                            height: size.height * 0.38,
                            width: size.width,
                            // height: 26.h,
                            child: CachedNetworkImage(
                              imageUrl: base + "${_homePageController.getsliderbaner?.bannerImageList![index].toString()}",fit: BoxFit.fitWidth,
                              placeholder: (context, url) => SizedBox(
                                height: 1.h,
                                  width: 4.w,
                                  child: Center(
                                      child: Image.asset("lib/assets/asset/zif_loading6.gif"),
                                      //CircularProgressIndicator()
                                  )
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
                            ),


                            // FadeInImage.assetNetwork(
                            //   placeholder: 'lib/assets/asset/zif_loading5.gif',fadeInCurve: Curves.linear,
                            //   image: base +'${_homePageController.getsliderbaner?.bannerImageList![index].toString()}',fit: BoxFit.fitWidth,
                            // ),

                            ///
                            // Image.network(
                            //   base +
                            //       '${_homePageController.getsliderbaner?.bannerImageList![index].toString()}',
                            //   fit: BoxFit.fitWidth,
                            //   errorBuilder: (context, error, stackTrace) {
                            //     return Text(
                            //       'No Image',
                            //       style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 12.sp,
                            //       ),
                            //     );
                            //   },
                            // ),
                          ),
                        );
                      },
                      slideTransform: ZoomOutSlideTransform(),
                      slideIndicator: CircularSlideIndicator(
                        indicatorBorderWidth: 2,
                        indicatorRadius: 4,
                        itemSpacing: 15,
                        currentIndicatorColor: Colors.white,
                        padding: EdgeInsets.only(bottom: 11),
                      ),
                      itemCount: _homePageController.getsliderbaner!.bannerImageList!.length,
                      enableAutoSlider: true,
                    ),

                    // FutureBuilder<List<String>>(
                    //   future: getData(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       var items = snapshot.data;
                    //       var base = 'https://api.gyros.farm/Images/';
                    //       return Container(
                    //         height: 26.h,
                    //         child: CarouselSlider.builder(
                    //           //scrollPhysics: NeverScrollableScrollPhysics(),
                    //           key: _sliderKey,
                    //           unlimitedMode: true,
                    //           autoSliderTransitionTime: Duration(seconds: 2),
                    //           //autoSliderDelay: Duration(seconds: 5),
                    //           slideBuilder: (index) {
                    //             return Container(
                    //               height: 26.h,
                    //               alignment: Alignment.center,
                    //               decoration: BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: NetworkImage(base + '${items![index]}'),
                    //                     fit: BoxFit.fill),
                    //               ),
                    //             );
                    //           },
                    //           slideTransform: ZoomOutSlideTransform(),
                    //           slideIndicator: CircularSlideIndicator(
                    //             indicatorBorderWidth: 2,
                    //             indicatorRadius: 4,
                    //             itemSpacing: 15,
                    //             currentIndicatorColor: Colors.white,
                    //             padding: EdgeInsets.only(bottom: 6),
                    //           ),
                    //           itemCount: items!.length,
                    //           enableAutoSlider: true,
                    //         ),
                    //       );
                    //
                    //       /*  ListView(
                    //         physics: NeverScrollableScrollPhysics(),
                    //         children: <Widget>[
                    //           Container(
                    //             height: 26.h,
                    //             child: CarouselSlider.builder(
                    //               //scrollPhysics: NeverScrollableScrollPhysics(),
                    //               key: _sliderKey,
                    //               unlimitedMode: true,
                    //               autoSliderTransitionTime: Duration(seconds: 2),
                    //               //autoSliderDelay: Duration(seconds: 5),
                    //               slideBuilder: (index) {
                    //                 return Container(
                    //                   height: 26.h,
                    //                   alignment: Alignment.center,
                    //                   decoration: BoxDecoration(
                    //                     image: DecorationImage(
                    //                         image: NetworkImage('${'Images'}'),
                    //                         fit: BoxFit.fill),
                    //                   ),
                    //                   //color: colors[index],
                    //                   // child: Text(
                    //                   //   letters[index],
                    //                   //   style: TextStyle(fontSize: 200, color: Colors.white),
                    //                   // ),
                    //                 );
                    //               },
                    //               slideTransform: ZoomOutSlideTransform(),
                    //               slideIndicator: CircularSlideIndicator(
                    //                 indicatorBorderWidth: 2,
                    //                 indicatorRadius: 4,
                    //                 itemSpacing: 15,
                    //                 currentIndicatorColor: Colors.white,
                    //                 padding: EdgeInsets.only(bottom: 6),
                    //               ),
                    //               itemCount: images.length,
                    //               enableAutoSlider: true,
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.symmetric(vertical: 1),
                    //             child: Align(
                    //               child: ConstrainedBox(
                    //                 constraints:
                    //                     BoxConstraints(minWidth: 190, maxWidth: 600),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       );*/
                    //     } else if (snapshot.hasError) {
                    //       return Text("${snapshot.error}");
                    //     }
                    //     return Center(
                    //         child: CircularProgressIndicator(
                    //       color: Colors.white,
                    //     ));
                    //   },
                    // )
                  ),
      ),
    );
  }
}
