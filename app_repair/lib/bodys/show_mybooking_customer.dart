import 'dart:convert';

import 'package:app_repair/bodys/show_detail_service_customer.dart';

import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_title.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowBookingCustomer extends StatefulWidget {
  const ShowBookingCustomer({Key? key}) : super(key: key);

  @override
  _ShowBookingCustomerState createState() => _ShowBookingCustomerState();
}

bool load = true;
bool? haveData;
List<ServiceCustomer> ServiceCustomerModels = [];

class _ShowBookingCustomerState extends State<ShowBookingCustomer> {


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
      itemCount: ServiceCustomerModels.length,
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
                          'บริการ' +
                              ServiceCustomerModels[index].typeRepairer,
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
                                      ShowDetailServiceCustomer(serviceCustomerModel: ServiceCustomerModels[index],),
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
                      ServiceCustomerModels[index].date1 +
                          ',' +
                          ServiceCustomerModels[index].identifySymptoms,
                      style: MyConstant().h3BlackStyle(),
                    )
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
