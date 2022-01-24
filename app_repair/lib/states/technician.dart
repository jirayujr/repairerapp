import 'dart:convert';
import 'package:app_repair/bodys/show_currentjob_technician.dart';
import 'package:app_repair/bodys/show_message.dart';
import 'package:app_repair/bodys/show_newjob_technician.dart';
import 'package:app_repair/bodys/show_setting_technician.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
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
  UserModel? userModel;
  int indexpage = 0;

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
          widgets.add(
            ShowCurrentJob(),
          );
          widgets.add(
            ShowNewJob(),
          );
          widgets.add(
            ShowMessage(),
          );
          widgets.add(ShowSettingTechnician(userModel: userModel!));
        });
      }
    });
  }

   BottomNavigationBarItem showCurrentJob() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.list_alt),
      title: Text('MyJob'),
      backgroundColor: Colors.orange.shade500
    );
  }

  BottomNavigationBarItem showNewJob() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.notifications_active),
      title: Text('NewJob'),
      backgroundColor: Colors.orange.shade500
    );
  }

  BottomNavigationBarItem showMessage() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.message),
      title: Text('Message'),
      backgroundColor: Colors.orange.shade500
    );
  }

  BottomNavigationBarItem showSetting() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.admin_panel_settings),
      title: Text('Profile'),
      backgroundColor: Colors.orange.shade500
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Text('Technician'),
        actions: [buildLogOut()],
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
      body: widgets.length == 0 ? ShowProgress():widgets[indexpage],
      bottomNavigationBar: showBottomNavigationBar(),
    );
  }
    IconButton buildLogOut() {
    return IconButton(
        onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeAuthen, (route) => false),
                );
          },
        icon: Icon(Icons.logout));
  }
   

  BottomNavigationBar showBottomNavigationBar() => BottomNavigationBar(
        currentIndex: indexpage,
        onTap: (value) {
          setState(() {
            indexpage = value;
          });
        },
        items: <BottomNavigationBarItem>[
          showCurrentJob(),
          showNewJob(),
          showMessage(),
          showSetting(),
        ],
      );
}
