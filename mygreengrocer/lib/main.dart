import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:mygreengrocer/src/pages_routes/app_pages.dart';

void main() {
  //Verificação se todos os componentes/bibliotecas estão carregados
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Greengrocer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(200),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
