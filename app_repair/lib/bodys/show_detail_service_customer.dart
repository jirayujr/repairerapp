import 'package:app_repair/backend/backend.dart';
import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/states/submit_service_customer.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class ShowDetailServiceCustomer extends StatefulWidget {
  final ServiceCustomer serviceCustomerModel;
  const ShowDetailServiceCustomer(
      {Key? key, required this.serviceCustomerModel})
      : super(key: key);

  @override
  _ShowDetailServiceState createState() => _ShowDetailServiceState();
}

class _ShowDetailServiceState extends State<ShowDetailServiceCustomer> {
  ServiceCustomer? serviceCustomerModel;
  TextEditingController dateController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();




  Future<Null> readDetailBooking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    //print('## id login ==>$id');
    //backend obj = new backend();
    //nameWithBoom = await obj.showFirstName('$id');
    //backend obj = new backend();
    //nameWithBoom = await obj.showFirstName('$id');
    //print(nameWithBoom);
    //String name = await obj.showFirstName('$id');
    //Text(name);
  }

  /*Future<void> getFirstName() async {
    backend obj = new backend();
    String text = await obj.showFirstName('1');
    print('text:: $text');
    setState(() {
      nameWithBoom = text;
    });
    print("nameWithBoom:: $nameAddBoom");
  }*/

  List<String> pathImages = [];

  @override
  void initState() {
    readDetailBooking();
    //getFirstName();
    // TODO: implement initState
    //String text = nameWithBoom;
    //print("======");
    //print(nameWithBoom);
    //print("=========");
    serviceCustomerModel = widget.serviceCustomerModel;
    dateController.text = serviceCustomerModel!.date1;
    detailController.text = serviceCustomerModel!.identifySymptoms;
    addressController.text = serviceCustomerModel!.address1;
    //nameAddBoom.text = nameWithBoom;
    //print("+++++++++++++++++");
    //print(nameAddBoom.text.toString());
  }

  /* _getImagesPath() async {
    backend obj = new backend();
    return await obj.showFirstName('1');
  }*/

  @override
  Widget build(BuildContext context) {
    print('Fetching user order...');
    /*String imagesPath = "";
    _getImagesPath().then((path) {
      imagesPath = path;
      print("get::$imagesPath"); //prints correct path
    });
    print("get::$imagesPath"); //prints correct path*/
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade100,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow.shade900, Colors.yellowAccent.shade700],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          title: Text('รายละเอียดการซ่อม'),
        ),
        backgroundColor: Colors.orange.shade100,
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildshowdate(constraints),
                  // Row(
                  //   children: [
                  //     CachedNetworkImage(
                  //         imageUrl:
                  //             '${MyConstant.domain}/repairer_app/${pathImages[0]}'),
                  //   ],
                  // ),
                  buildshowdetail(constraints),
                  buildshowname(constraints),
                  buildphone(constraints),
                  buildaddress(constraints),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxWidth * 0.6,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              double.parse(serviceCustomerModel!.lat),
                              double.parse(serviceCustomerModel!.lng),
                            ),
                            zoom: 16,
                          ),
                          markers: <Marker>[
                            Marker(
                                markerId: MarkerId('id'),
                                position: LatLng(
                                  double.parse(serviceCustomerModel!.lat),
                                  double.parse(serviceCustomerModel!.lng),
                                ),
                                infoWindow: InfoWindow(
                                    title: 'You Here ',
                                    snippet:
                                        'lat = ${serviceCustomerModel!.lat}, lng = ${serviceCustomerModel!.lng}')),
                          ].toSet(),
                        ),
                      ),
                    ],
                  ),
                  buildCancelButton(constraints),
                ],
              ),
            ),
          ),
        ));
  }

  Container buildCancelButton(BoxConstraints constraints) {
    return Container(
      width: constraints.maxHeight * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          print('##  ==> click cancel');
        },
        child: Text('ยกเลิก'),
      ),
    );
  }

  Row buildshowdate(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'วันที่นัดใช้บริการ ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                dateController.text,
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildshowdetail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'รายละเอียดสิ่งที่ต้องการซ่อม ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                detailController.text,
                style: MyConstant().h4Style(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildshowname(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ผู้รับบริการ ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                  Text(
                    '',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                '',
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildaddress(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ที่อยู่ ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                addressController.text,
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildphone(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'เบอร์โทรศัพท์ ',
                    style: MyConstant().h3GrayStyle(),
                  ),
                ],
              ),
              Text(
                phoneController.text,
                style: MyConstant().h4Style(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
