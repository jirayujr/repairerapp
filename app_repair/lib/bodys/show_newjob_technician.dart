import 'package:flutter/material.dart';
class ShowNewJob extends StatefulWidget {
  const ShowNewJob({ Key? key }) : super(key: key);

  @override
  _ShowCurrentJobState createState() => _ShowCurrentJobState();
}

class _ShowCurrentJobState extends State<ShowNewJob> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:  Text('Show งานมาใหม่'),
    );
  }
}