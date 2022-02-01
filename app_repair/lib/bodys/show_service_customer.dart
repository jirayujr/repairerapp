import 'package:app_repair/states/submit_service_customer.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_image.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:flutter/material.dart';

class ShowServiceCustomer extends StatefulWidget {
  const ShowServiceCustomer({Key? key}) : super(key: key);

  @override
  _ShowServiceCustomerState createState() => _ShowServiceCustomerState();
}

class _ShowServiceCustomerState extends State<ShowServiceCustomer> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              buildSearchButton(constraints),
              buildTitle('เลือกประเภทช่าง'),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  splashColor: Colors.orange.shade100,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SubmitService();
                        },
                      ),
                    );
                  },
                  child: Ink.image(
                    image: AssetImage('images/1.png'),
                    width: 175,
                    height: 175,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: InkWell(
                  splashColor: Colors.orange.shade100,
                  onTap: () {Navigator.pushNamed(context, MyConstant.routeSubmitService);
                        },
                   
                  child: Ink.image(
                    image: AssetImage('images/2.png'),
                    width: 175,
                    height: 175,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: InkWell(
                  splashColor: Colors.orange.shade100,
                  onTap: () {
                   Navigator.pushNamed(context, MyConstant.routeSubmitService);
                  },
                  child: Ink.image(
                    image: AssetImage('images/3.png'),
                    width: 175,
                    height: 175,
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Container buildSearchButton(BoxConstraints constraints) {
    return Container(
      width: constraints.maxHeight * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeSubmitService),
        child: Text('ระบุอาการ'),
      ),
    );
  }
}



Container buildTitle(String title) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(vertical: 16),
    child: ShowTitle(
      title: title,
      textStyle: MyConstant().h2BlackStyle(),
    ),
  );
}
