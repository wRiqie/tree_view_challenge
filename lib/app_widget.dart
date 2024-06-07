import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/theme/app_theme.dart';
import 'app_binding.dart';
import 'routes/app_pages.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tree View App',
      getPages: AppPages.pages,
      initialRoute: AppRoutes.home,
      initialBinding: AppBinding(),
      theme: appTheme,
    );
  }
}
