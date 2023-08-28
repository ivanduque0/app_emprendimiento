import 'dart:io';

import 'package:app_emprendimiento/db/db_helper.dart';
import 'package:app_emprendimiento/main/presentation/getx/main_binding.dart';
import 'package:app_emprendimiento/main/presentation/routes/main_navigation.dart';
import 'package:app_emprendimiento/order/presentation/routes/stock_navigation.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'stock/presentation/routes/stock_navigation.dart'; 

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('es'),  
      ],
      title: 'App Emprendimiento',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      initialRoute: MainRoutes.main,
      getPages: [
        MainPages.MainPageRoute,
        OrderPages.AddOrderPageRoute,
        StockPages.AddToStockPageRoute
      ],
      initialBinding: MainBinding(),
    );
  }
}

