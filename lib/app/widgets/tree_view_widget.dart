import 'package:flutter/material.dart';
import 'package:tree_view_challenge/app/data/models/tree_node_model.dart';

import 'tree_node_widget.dart';

class TreeViewWidget extends StatefulWidget {
  final List<TreeNodeModel> nodes;
  final double indent;
  const TreeViewWidget({super.key, this.nodes = const [], this.indent = 20});

  @override
  State<TreeViewWidget> createState() => _TreeViewWidgetState();
}

class _TreeViewWidgetState extends State<TreeViewWidget> {
  List<Widget> treeNodes = [];

  @override
  void initState() {
    super.initState();
    _buildTreeNodes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: treeNodes,
    );
  }

  void _buildTreeNodes() {
    for (var node in widget.nodes) {
      treeNodes.add(TreeNodeWidget(
        treeNode: node,
        indent: widget.indent,
      ));
    }
    setState(() {});
  }
}
