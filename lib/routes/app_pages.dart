import 'package:get/get.dart';
import 'package:tree_view_challenge/app/modules/assets/assets_binding.dart';
import 'package:tree_view_challenge/app/modules/assets/assets_page.dart';
import 'package:tree_view_challenge/app/modules/home/home_binding.dart';
import 'package:tree_view_challenge/app/modules/home/home_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.assets,
      page: () => const AssetsPage(),
      binding: AssetsBinding(),
    ),
  ];
}
