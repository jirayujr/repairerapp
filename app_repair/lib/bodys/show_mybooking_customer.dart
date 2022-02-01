import 'dart:convert';

import 'package:app_repair/bodys/show_detail_service_customer.dart';

import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:app_repair/backend/backend.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowBookingCustomer extends StatefulWidget {
  const ShowBookingCustomer({Key? key}) : super(key: key);

  @override
  _ShowBookingCustomerState createState() => _ShowBookingCustomerState();
}

class _ShowBookingCustomerState extends State<ShowBookingCustomer> {
  bool load = true;
  bool? haveData;
  List<ServiceCustomer> servicecustomerModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readMybooking();
  }

  Future<Null> readMybooking() async {
    if (servicecustomerModels.length != 0) {
      servicecustomerModels.clear();
    } else {}

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');

    String showMyBooking =
        '${MyConstant.domain}/repairer_app/getServiceWhereUser.php?isAdd=true&id=$id';
    await Dio().get(showMyBooking).then((value) {
      //print('==>$value');

      if (value.toString() == 'null') {
        // No Data
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        // Have Data
        for (var item in json.decode(value.data)) {
          ServiceCustomer model = ServiceCustomer.fromMap(item);
          print('detail ==>> ${model.identifySymptoms}');

          setState(() {
            load = false;
            haveData = true;
            servicecustomerModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: load
          ? ShowProgress()
          : haveData!
              ? LayoutBuilder(
                  builder: (context, constraints) => buildListView(constraints))
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShowTitle(
                        title: 'ยังไม่มีรายการซ่อม',
                        textStyle: MyConstant().h1BlackStyle()),
                    ShowTitle(
                        title: 'เมื่อทำการแจ้งซ่อม รายการแจ้งซ่อมจะขึ้นที่นี่',
                        textStyle: MyConstant().h2BlackStyle()),
                  ],
                )),
    );
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: servicecustomerModels.length,
      itemBuilder: (context, index) => Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              width: 50,
              height: 50,
              child: Icon(Icons.handyman_rounded),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                           servicecustomerModels[index].typeRepairer,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print('## click Detail');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShowDetailServiceCustomer(
                                    serviceCustomerModel:
                                        servicecustomerModels[index],
                                  ),
                                ));
                          },
                          icon:
                              Icon(Icons.arrow_forward_ios_outlined, size: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      servicecustomerModels[index].date1 +
                          ',' +
                          servicecustomerModels[index].identifySymptoms,
                      style: MyConstant().h4Style(),
                    ),
                    Text(
                      'สถานะ'+
                           
                          servicecustomerModels[index].identifySymptoms,
                      style: MyConstant().h3BlackStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
