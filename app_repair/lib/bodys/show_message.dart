import 'package:flutter/material.dart';
class ShowMessage extends StatefulWidget {
  const ShowMessage({ Key? key }) : super(key: key);

  @override
  _ShowMessageState createState() => _ShowMessageState();
}

class _ShowMessageState extends State<ShowMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:  Text('Show message'),
      
    );
  }
}