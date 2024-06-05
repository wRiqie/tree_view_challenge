import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'assets_controller.dart';

class AssetsPage extends GetView<AssetsController> {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assets')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: TextField(
              decoration: InputDecoration(
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
          const Expanded(
            child: SingleChildScrollView(
              child: Column(),
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
