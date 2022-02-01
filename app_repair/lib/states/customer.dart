import 'dart:convert';
import 'package:app_repair/bodys/show_mybooking_customer.dart';
import 'package:app_repair/bodys/show_service_customer.dart';
import 'package:app_repair/bodys/show_setting_customer.dart';
import 'package:app_repair/bodys/show_message.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_signout.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  List<Widget> widgets = [
    
  ];
  int indexWidget = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    print('## id login ==>$id');
    String apiGetUserWhereId =
        '${MyConstant.domain}/repairer_app/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then((value) {
      //print('## value ==> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          widgets.add(ShowServiceCustomer(),);
          widgets.add(ShowBookingCustomer(),);
          widgets.add(ShowMessage(),);
          widgets.add(ShowSettingCustomer(userModel: userModel!));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.shade900, Colors.yellowAccent.shade700],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      drawer: widgets.length ==0 ?  SizedBox():Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                buildHeader(),
                menuShowService(),
                menuShowMyBooking(),
                menuMessage(),
                menuShowSetting(),
              ],
            ),
          ],
        ),
      ),
      body: widgets.length == 0 ? ShowProgress():widgets[indexWidget],
      backgroundColor: Colors.amber.shade900,
    );
  }

  UserAccountsDrawerHeader buildHeader() {
    return UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundImage:
              NetworkImage('${MyConstant.domain}${userModel?.avatar}'),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade900, Colors.yellowAccent.shade700],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        accountName: Text(userModel == null
            ? 'Name'
            : userModel!.firstname + '  ' + userModel!.lastname),
        accountEmail: Text(userModel == null ? 'Type' : userModel!.type));
  }

  ListTile menuShowService() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.search_outlined),
      title: ShowTitle(title: 'Service', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
        title: 'บริการ',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowMyBooking() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.menu_book_outlined),
      title: ShowTitle(title: 'My Booking', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
        title: 'รายการ',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuMessage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.message_outlined),
      title: ShowTitle(title: 'Message', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
        title: 'ข้อความ',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowSetting() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 3;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.admin_panel_settings),
      title: ShowTitle(title: 'Profile', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
        title: 'โปรไฟล์',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }
}
