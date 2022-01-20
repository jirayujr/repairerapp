import 'package:app_repair/models/user_model.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowSettingCustomer extends StatefulWidget {
  final UserModel userModel;
  const ShowSettingCustomer({Key? key, required this.userModel})
      : super(key: key);

  @override
  _ShowSettingCustomerState createState() => _ShowSettingCustomerState();
}

class _ShowSettingCustomerState extends State<ShowSettingCustomer> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  Future<Null> refreshUserModel() async {
    print('## refreshUserModel Work');
    String apiGetUserWhereId =
        '${MyConstant.domain}/repairer_app/getUserWhereId.php?isAdd=true&id=${userModel!.id}';
    await Dio().get(apiGetUserWhereId).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange.shade100,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange.shade800,
          child: Icon(Icons.edit),
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeEditProfileCustomer)
                  .then((value) => refreshUserModel()),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowTitle(
                      title: 'ข้อมูลผู้ใช้',
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  ShowTitle(title: 'ชื่อ :', textStyle: MyConstant().h2Style()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShowTitle(
                            title: userModel!.firstname +
                                '      ' +
                                userModel!.lastname,
                            textStyle: MyConstant().h1BlackStyle()),
                      ),
                    ],
                  ),
                  
                  ShowTitle(
                      title: 'เบอร์ : ', textStyle: MyConstant().h2Style()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: constraints.maxWidth * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShowTitle(
                            title: userModel!.phone,
                            textStyle: MyConstant().h2BlackStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ShowTitle(
                        title: 'รูปโปรไฟล์ :',
                        textStyle: MyConstant().h2Style()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        width: constraints.maxWidth * 0.6,
                        child: CachedNetworkImage(
                          imageUrl: '${MyConstant.domain}${userModel!.avatar}',
                          placeholder: (context, url) => ShowProgress(),
                        ),
                      ),
                    ],
                  ),
                  ShowTitle(
                      title: 'ที่อยู่ :', textStyle: MyConstant().h2Style()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: constraints.maxWidth * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShowTitle(
                            title: userModel!.address,
                            textStyle: MyConstant().h2BlackStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ShowTitle(
                      title: 'Location :', textStyle: MyConstant().h2Style()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        width: constraints.maxWidth * 0.6,
                        height: constraints.maxWidth * 0.6,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              double.parse(userModel!.lat),
                              double.parse(userModel!.lng),
                            ),
                            zoom: 16,
                          ),
                          markers: <Marker>[
                            Marker(
                                markerId: MarkerId('id'),
                                position: LatLng(
                                  double.parse(userModel!.lat),
                                  double.parse(userModel!.lng),
                                ),
                                infoWindow: InfoWindow(
                                    title: 'You Here ',
                                    snippet:
                                        'lat = ${userModel!.lat}, lng = ${userModel!.lng}')),
                          ].toSet(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
