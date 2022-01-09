import 'package:app_repair/bodys/submit_service_customer.dart';
import 'package:app_repair/bodys/search_service.dart';
import 'package:app_repair/states/authen.dart';
import 'package:app_repair/states/create_account.dart';
import 'package:app_repair/states/customer.dart';
import 'package:app_repair/states/technician.dart';
import 'package:app_repair/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/customer': (BuildContext context) => Customer(),
  '/technician': (BuildContext context) => Technician(),
  '/searchservice': (BuildContext context) => SearchService(),
  '/submitservice': (BuildContext context) => SubmitService(),
  
};

String? initialRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initialRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'user':
        initialRoute = MyConstant.routeCustomerService;
        runApp(MyApp());
        break;
      case 'technician':
        initialRoute = MyConstant.routeTechnicianService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
