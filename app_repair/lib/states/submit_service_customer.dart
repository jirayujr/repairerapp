import 'dart:io';
import 'package:app_repair/utility/my_dialog.dart';
import 'package:app_repair/widgets/show_progress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_repair/widgets/show_image.dart';
import 'package:flutter/material.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:app_repair/widgets/show_title.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class SubmitService extends StatefulWidget {
  const SubmitService({Key? key}) : super(key: key);

  @override
  _SubmitServiceState createState() => _SubmitServiceState();
}

class _SubmitServiceState extends State<SubmitService> {
  DateTime _dateTime = new DateTime.now();
  TimeOfDay _timeOfDay = new TimeOfDay.now();

  final items = [
    'ช่างกุญแจ',
    'ช่างคอม',
    'ช่างงานโครงสร้าง',
    'ช่างซ่อมมือถือ',
    'ช่างซ่อมรถ',
    'ช่างทาสี',
    'ช่างประปา',
    'ช่างไฟฟ้า',
    'ช่างวอลเปเปอร์',
    'ช่างแอร์',
  ];

  final formkey = GlobalKey<FormState>();
  String? value;
  List<File?> files = [];
  File? file;
  double? lat, lng;

  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // findLatLng()
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // findLatLng()
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(
          context, 'Location Service ปิดอยู่', ' กรุณาเปิด Location Service ');
    }
  }

  Future<Null> findLatLng() async {
    print('finadLatLan ==> Work');
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat = $lat,lng = $lng');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFile();
    checkPermission();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('แจ้งอาการ'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.shade900, Colors.yellowAccent.shade700],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.orange.shade100,
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        DateTime? _newDate = await showDatePicker(
                            context: context,
                            initialDate: _dateTime,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1));
                        if (_newDate != null) {
                          setState(() {
                            _dateTime = _newDate;
                          });
                        }
                      },
                      child: Text('เลือกวันที่')),
                  buildTitle(
                      '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}'),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        TimeOfDay? _newTime = await showTimePicker(
                          context: context,
                          initialTime: _timeOfDay,
                        );

                        if (_newTime != null) {
                          setState(() {
                            _timeOfDay = _newTime;
                          });
                        }
                      },
                      child: Text('เลือกเวลา')),
                  buildTitle('${_timeOfDay.hour}:${_timeOfDay.minute}'),
                  buildTitle2('เลือกประเภทช่าง'),
                  buildSelectTech(),
                  buildTitle2('ระบุอาการ'),
                  buildTextField(),
                  buildImage(constraints),
                  buildTitle2('ที่อยู่'),
                  buildAddress(),
                  buildTitle2('แสดงพิกัดของคุณ'),
                  buildLo(),
                  buildSubmitButton(constraints),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        file = File(result!.path);
        files[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    print('Click From index ==>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.logo),
          title: ShowTitle(
              title: 'เพิ่มรูปภาพที่ ${index + 1} ?',
              textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: 'Please Tab on Camera or Gallery',
              textStyle: MyConstant().h3Style()),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.camera, index);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildAddress() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 4)),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกที่อยู่';
          } else {
            return null;
          }
        },
        maxLines: 4,
        decoration: InputDecoration(
          labelStyle: MyConstant().h3BlackStyle(),
        ),
      ),
    );
  }

  Container buildSubmitButton(BoxConstraints constraints) {
    return Container(
      width: constraints.maxHeight * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          if (formkey.currentState!.validate()) {}
        },
        child: Text('แจ้งซ่อม'),
      ),
    );
  }

  Container buildSelectTech() {
    return Container(
       alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(43,8, 43,8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 4)),
      child: DropdownButton<String>(
          value: value,
          iconSize: 36,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          isExpanded: true,
          items: items.map(buildMenuItem).toList(),
          onChanged: (value) => setState(
                () => this.value = value,
              )),
    );
  }

  Container buildTextField() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 4)),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาระบุรายละเอียด';
          } else {
            return null;
          }
        },
        maxLines: 4,
        decoration: InputDecoration(
          labelStyle: MyConstant().h3BlackStyle(),
        ),
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
            width: constraints.maxWidth * 0.6,
            height: constraints.maxWidth * 0.6,
            child: file == null
                ? Image.asset(MyConstant.image)
                : Image.file(file!)),
        Container(
          width: constraints.maxWidth * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                    onTap: () => chooseSourceImageDialog(0),
                    child: files[0] == null
                        ? Image.asset(MyConstant.addimage)
                        : Image.file(
                            files[0]!,
                            fit: BoxFit.cover,
                          )),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                    onTap: () => chooseSourceImageDialog(1),
                    child: files[1] == null
                        ? Image.asset(MyConstant.addimage)
                        : Image.file(
                            files[1]!,
                            fit: BoxFit.cover,
                          )),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                    onTap: () => chooseSourceImageDialog(2),
                    child: files[2] == null
                        ? Image.asset(MyConstant.addimage)
                        : Image.file(
                            files[2]!,
                            fit: BoxFit.cover,
                          )),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                    onTap: () => chooseSourceImageDialog(3),
                    child: files[3] == null
                        ? Image.asset(MyConstant.addimage)
                        : Image.file(
                            files[3]!,
                            fit: BoxFit.cover,
                          )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2BlackStyle(),
      ),
    );
  }

  Container buildTitle2(String title) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow:
              InfoWindow(title: 'คุณอยู่ที่นี่', snippet: 'Lat=$lat, lng=$lng'),
        ),
      ].toSet();

  Widget buildLo() => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(8,8, 8, 8),
        height: 200,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );
}