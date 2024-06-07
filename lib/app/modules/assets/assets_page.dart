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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar Ativo ou Local',
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
                    _buildOption(
                      Icons.bolt_outlined,
                      'Sensor de Energia',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildOption(
                      Icons.info_outline,
                      'Crítico',
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
                    if (controller.nodes.isNotEmpty) {
                      return ListView.builder(
                        itemCount: controller.nodes.length,
                        itemBuilder: (context, index) {
                          var treeNode = controller.nodes[index];
                          return TreeNodeWidget(
                            treeNode: treeNode,
                            indent: 20,
                          );
                        },
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

  Widget _buildOption(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey.shade500,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
