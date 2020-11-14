import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/pages/view/barang_page.dart';
import 'package:pos_flutter/pages/create/create_merek_page.dart';
import 'package:pos_flutter/pages/view/distributor_page.dart';
import 'package:pos_flutter/pages/view/home_page.dart';
import 'package:pos_flutter/pages/view/login_page.dart';
import 'package:pos_flutter/pages/view/merek_page.dart';
import 'package:pos_flutter/services/auth_services.dart';
import 'package:pos_flutter/services/user_validation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventaris',
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => UserValidation(),
          ),
          GetPage(
            name: '/home',
            page: () => HomePage(),
          ),
          GetPage(
            name: '/login',
            page: () => LoginPage(),
          ),
          GetPage(
            name: '/barang',
            page: () => BarangPage(),
          ),
          GetPage(
            name: '/merek',
            page: () => MerekPage(),
          ),
          GetPage(
            name: '/distributor',
            page: () => DistributorPage(),
          ),
          GetPage(
            name: '/createMerek',
            page: () => CreateMerekPage(),
          ),
        ],
      ),
    );
  }
}
