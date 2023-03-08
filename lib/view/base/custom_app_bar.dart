import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final Function onBackPressed;
  CustomAppBar({@required this.title, this.isBackButtonExist = true, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: Text(title, style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).cardColor)),
      centerTitle: true,
      leading: isBackButtonExist ? IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Theme.of(context).cardColor,
        onPressed: () => onBackPressed != null ? onBackPressed() : Navigator.pop(context),
      ) : SizedBox(),
      backgroundColor:  Color(0xffFDA613),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
