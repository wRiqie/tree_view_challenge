import 'package:flutter/material.dart';
import 'package:tree_view_challenge/app/data/models/tree_node_model.dart';

import 'tree_node_widget.dart';

class TreeViewWidget extends StatelessWidget {
  final List<TreeNodeModel> nodes;
  final double indent;
  const TreeViewWidget({super.key, this.nodes = const [], this.indent = 20});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: nodes
          .map((e) => TreeNodeWidget(
                treeNode: e,
                indent: indent,
              ))
          .toList(),
    );
  }
}
