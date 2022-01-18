import 'package:flutter/material.dart';
class ShowCurrentJob extends StatefulWidget {
  const ShowCurrentJob({ Key? key }) : super(key: key);

  @override
  _ShowCurrentJobState createState() => _ShowCurrentJobState();
}

class _ShowCurrentJobState extends State<ShowCurrentJob> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:  Text('Show งานปัจจุบัน'),
    );
  }
}