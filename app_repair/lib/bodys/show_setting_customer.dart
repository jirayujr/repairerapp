import 'package:flutter/material.dart';
class ShowSettingCustomer extends StatefulWidget {
  const ShowSettingCustomer({ Key? key }) : super(key: key);

  @override
  _ShowSettingCustomerState createState() => _ShowSettingCustomerState();
}

class _ShowSettingCustomerState extends State<ShowSettingCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:  Text('Show Setting'),
    );
  }
}