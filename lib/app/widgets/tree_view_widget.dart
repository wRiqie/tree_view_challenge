import 'package:flutter/material.dart';

import 'tree_node_widget.dart';

class TreeViewWidget extends StatefulWidget {
  final List<TreeNode> nodes;
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
