import 'package:flutter/material.dart';

class MyConstant {
//  General
  static String appName = 'Repairer';
  static String domain = 'http://10.0.2.2'; // route to localhost

//  Route

  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeCustomerService = '/customer';
  static String routeTechnicianService = '/technician';
  static String routeSearchService = '/searchservice';
  static String routeSubmitService = '/submitservice';
  static String routeEditProfileCustomer = '/editprofilecustomer';
  static String routeEditProfileTechnician = '/editprofiletechnician';
  static String routeShowBookingCustomer = '/showbookingcustomer';

// Images
  static String logo = 'images/logo.png';
  static String avatar = 'images/avatar.png';
  static String electric = 'images/1.png';
  static String computer = 'images/2.png';
  static String water = 'images/3.png';
  static String image = 'images/fillimage.png';
  static String fixlogo = 'images/fix.png';
  static String addimage = 'images/addimage.png';

// Color
  static Color primary = Colors.yellowAccent.shade50;
  static Color dark = Colors.yellow.shade900;
  static Color light = Colors.yellow.shade300;
  static Color black = Colors.black;

// Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h1BlackStyle() => TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2BlackStyle() => TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 12,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3BlackStyle() => TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3GrayStyle() => TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      );

  TextStyle h4Style() => TextStyle(
        fontSize: 14,
        color: black,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
