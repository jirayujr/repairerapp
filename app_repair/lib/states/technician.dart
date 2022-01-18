import 'dart:convert';

import 'package:app_repair/bodys/show_currentjob_technician.dart';
import 'package:app_repair/bodys/show_message.dart';
import 'package:app_repair/bodys/show_newjob_technician.dart';
import 'package:app_repair/bodys/show_setting_technician.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_signout.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Technician extends StatefulWidget {
  const Technician({Key? key}) : super(key: key);

  @override
  _TechnicianState createState() => _TechnicianState();
}


class _TechnicianState extends State<Technician> {
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
      print('## value ==> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          widgets.add(ShowCurrentJob(),);
          widgets.add(ShowNewJob(),);
          widgets.add(ShowMessage(),);
          widgets.add(ShowSettingTechnician(userModel: userModel!));
        });
      }
    });
  }

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                menuShowCurrentJob(),
                menuShowNewJob(),
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

  ListTile menuShowCurrentJob() {
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
        title: 'งานปัจจุบัน',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowNewJob() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.menu_book_outlined),
      title: ShowTitle(title: 'New Job', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
        title: 'งานมาใหม่',
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
      leading: Icon(Icons.settings_applications_outlined),
      title: ShowTitle(title: 'Setting', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
        title: 'ตั้งค่า',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }
 
}
