import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/data/services/storage_service.dart';
import 'package:flutter_good_practices/app/routes/app_pages.dart';
import 'package:flutter_good_practices/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(),
    GetStorage.init(),
    Get.putAsync(() => StorageService().init()),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Good Pratices',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: Routes.APONTAMENTOSSCREEN,
      getPages: AppPages.routes,
    );
  }
}
