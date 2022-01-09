import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_signout.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Technician extends StatefulWidget {
  const Technician({Key? key}) : super(key: key);

  @override
  _TechnicianState createState() => _TechnicianState();
}

class _TechnicianState extends State<Technician> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technician'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.shade900, Colors.yellowAccent.shade700],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        backgroundColor: Colors.yellow.shade900,
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
