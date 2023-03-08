import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chat/chat_screen.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String image;
  final String name;
  final String address;
  final String phone;
  final String latitude;
  final String longitude;
  final bool showButton;
  InfoCard({ this.title,  this.image,  this.name,  this.address,  this.phone,
     this.latitude,  this.longitude,  this.showButton});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Color(0xffFDA613),
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        // boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        Text(title, style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Colors.black)),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

          ClipOval(child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder, height: 40, width: 40, fit: BoxFit.cover,
            image: image,
            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 40, width: 40, fit: BoxFit.cover),
          )),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text(name, style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,color: Colors.black)),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

            Text(
              address,
              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color:Colors.black),
            ),

            showButton ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

             Align(
               alignment: Alignment.bottomRight,
               child: GestureDetector(
                 onTap: (){
                   Get.to(ChatScreen());
                 },
                 child: Container(
                   height: 50,
                   width: 50,
                   child: Icon(Icons.message,color:  Color(0xff2E4D4C),),
                 ),
               ),
             )

            ]) : SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

          ])),

        ]),

      ]),
    );
  }
}
