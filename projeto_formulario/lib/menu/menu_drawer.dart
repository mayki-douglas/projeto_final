import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_formulario/constant.dart';
import 'package:projeto_formulario/database/database.dart';
import 'package:projeto_formulario/views/about.dart';
import 'package:projeto_formulario/views/products_list.dart';
import 'package:projeto_formulario/views/register_product.dart';
import 'package:projeto_formulario/views/screen_1.dart';


class MenuDrawer extends StatelessWidget {

  Widget _createHeader(BuildContext context){
    return DrawerHeader(
      child: Stack(
        children: [
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text('Mayki: mayki.douglas1@gmail.com', style: TextStyle(fontSize: 14.0),),
          ),
          Positioned(
            top: 45.0,
            left: 16.0,
            child: Icon(Icons.account_circle_rounded, size: 50,),
          )
        ],
      ),
    );
  }

  Widget _createDrawerItem({IconData icon, String text, GestureTapCallback ontap}){
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          Padding(padding: EdgeInsets.only(left: 0.0),
            child: Text(text),
          )
        ],
      ),
      onTap: ontap,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _createHeader(context),
          SizedBox(height: 10.0,),
          _createDrawerItem(
            icon: Icons.home,
            text: Constant.MENU_HOME,
            ontap: () {
              Navigator.of(context).pop();
            }
          ),
          SizedBox(height: 10.0,),
          Divider(),
          _createDrawerItem(
              icon: Icons.wb_incandescent,
              text: Constant.MENU_SCREEN_1,
              ontap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Screen1()));
              }
          ),
          SizedBox(height: 10.0,),
          Divider(),
          _createDrawerItem(
            icon: Icons.add,
            text: Constant.MENU_REGISTER_PRODUCT,
            ontap: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(BuildContext context) => RegisterProduct()));
            }
          ),
          SizedBox(height: 10.0,),
          Divider(),
          _createDrawerItem(
            icon: Icons.info_outline,
            text: Constant.MENU_ABOUT,
            ontap: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(BuildContext context) => About()));
            }
          ),
          Divider(),
          _createDrawerItem(
            icon: Icons.exit_to_app,
            text: Constant.MENU_EXIT,
            ontap: () {
              if(Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            }
          )
        ],
      ),
    );
  }
}