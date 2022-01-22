import 'package:app_repair/models/service_customer.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  List<String> pathImages = [];

  @override
  void initState() {
    // TODO: implement initState

    serviceCustomerModel = widget.serviceCustomerModel;
    //print('## ชื่อที่ต้องการโชว์ ==> ${serviceCustomerModel!.firstname}');
    //nameController.text =
      //  serviceCustomerModel!.firstname + '  ' + serviceCustomerModel!.lastname;
    print('## images form mySQL ==> ${serviceCustomerModel?.image}');
    //convertStirngToArray();
    dateController.text =
        serviceCustomerModel!.date1 + ' ' + '(' + serviceCustomerModel!.time1+')';
    ;
    detailController.text = serviceCustomerModel!.identifySymptoms;
    addressController.text = serviceCustomerModel!.address1;
    //phoneController.text = serviceCustomerModel!.phone;
  }

  // void convertStirngToArray() {
  //   String string = serviceCustomerModel.images;
  // }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {print('##  ==> click cancel');
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
              )
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
                ],
              ),
              Text(
                nameController.text,
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
