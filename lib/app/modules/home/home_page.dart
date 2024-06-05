import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view_challenge/app/core/values/app_images.dart';
import 'package:tree_view_challenge/app/data/models/args/assets_args.dart';
import 'package:tree_view_challenge/routes/app_pages.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Image.asset(AppImages.logoTractian)),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
              child: Obx(
                () => Column(
                  children: controller.companies
                      .map((e) => ListTile(
                            onTap: () => Get.toNamed(
                              AppRoutes.assets,
                              arguments: AssetsArgs(companyId: e.id),
                            ),
                            title: Text(e.name),
                          ))
                      .toList(),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.isLoading.value,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ));
  }
}
