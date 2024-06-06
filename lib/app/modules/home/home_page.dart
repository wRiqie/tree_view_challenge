import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view_challenge/app/core/values/app_images.dart';

import '../../../routes/app_pages.dart';
import '../../data/models/args/assets_args.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Image.asset(AppImages.logoTractian)),
        body: Stack(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Selecione a unidade'),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: controller.companies.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          var company = controller.companies[index];
                          return ListTile(
                            tileColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onTap: () => Get.toNamed(
                              AppRoutes.assets,
                              arguments: AssetsArgs(companyId: company.id),
                            ),
                            leading: const Icon(
                              Icons.apartment,
                              color: Colors.white,
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                            title: Text(
                              '${company.name} Unit',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
