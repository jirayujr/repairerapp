import 'package:flutter/material.dart';
class ShowBookingCustomer extends StatefulWidget {
  const ShowBookingCustomer({ Key? key }) : super(key: key);

  @override
  _ShowBookingCustomerState createState() => _ShowBookingCustomerState();
}

class _ShowBookingCustomerState extends State<ShowBookingCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:  Text('Show booking'),
    );
  }
}