import 'package:flutter/material.dart';
import 'package:tree_view_challenge/app/data/models/tree_node_model.dart';

class TreeNode {
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final List<TreeNode> children;

  TreeNode({
    this.leading,
    this.trailing,
    required this.title,
    this.children = const [],
  });
}

class TreeNodeWidget extends StatefulWidget {
  final TreeNodeModel treeNode;
  final double indent;
  const TreeNodeWidget({super.key, required this.treeNode, this.indent = 0});

  @override
  State<TreeNodeWidget> createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    bool hasChildren = widget.treeNode.children.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: widget.indent),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          leading: hasChildren
              ? Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: !hasChildren ? Colors.grey.shade400 : null,
                )
              : const SizedBox(),
          title: Row(
            children: [
              widget.treeNode.leading ?? const SizedBox(),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Text(
                widget.treeNode.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          trailing: widget.treeNode.trailing,
        ),
        if (widget.treeNode.children.isNotEmpty && isExpanded)
          ...widget.treeNode.children.map(
            (e) => TreeNodeWidget(treeNode: e, indent: widget.indent + 20),
          )
      ],
    );
  }
}
