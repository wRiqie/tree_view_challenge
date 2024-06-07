import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view_challenge/app/widgets/empty_placeholder_widget.dart';
import 'package:tree_view_challenge/app/widgets/tree_node_widget.dart';

import 'assets_controller.dart';

class AssetsPage extends GetView<AssetsController> {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assets')),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 6),
                child: TextField(
                  controller: controller.searchCtrl,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Buscar Ativo ou Local',
                    suffixIcon: controller.searchCtrl.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              controller.searchCtrl.clear();
                            },
                            icon: const Icon(
                              Icons.clear,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Obx(
                      () => _buildOption(
                        icon: Icons.bolt_outlined,
                        title: 'Sensor de Energia',
                        isSelected: controller.isFilteringEnergy.value,
                        onTap: () => controller.toggleFilterEnergy(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => _buildOption(
                        icon: Icons.info_outline,
                        title: 'Crítico',
                        isSelected: controller.isFilteringCritical.value,
                        onTap: () => controller.toggleFilterCritical(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
              ),
              // TODO expand all button
              Expanded(
                child: Obx(() {
                  if (!controller.isLoading.value) {
                    if ((controller.nodes.isNotEmpty &&
                            !controller.isFiltering) ||
                        (controller.filteredNodes.isNotEmpty &&
                            controller.isFiltering)) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ListView.builder(
                          itemCount: controller.isFiltering
                              ? controller.filteredNodes.length
                              : controller.nodes.length,
                          itemBuilder: (context, index) {
                            var treeNode = controller.isFiltering
                                ? controller.filteredNodes[index]
                                : controller.nodes[index];
                            return TreeNodeWidget(
                              treeNode: treeNode,
                              indent: 20,
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: EmptyPlaceholderWidget(),
                      );
                    }
                  } else {
                    return Container();
                  }
                }),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading.value,
              child: const ColoredBox(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
      {required IconData icon,
      required String title,
      required bool isSelected,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
            color: isSelected ? Colors.blue : null,
            border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade400),
            borderRadius: BorderRadius.circular(3)),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade500,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
