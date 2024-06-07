import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view_challenge/app/core/values/app_images.dart';
import 'package:tree_view_challenge/app/data/models/asset_model.dart';
import 'package:tree_view_challenge/app/data/models/tree_node_model.dart';

class TreeNodeWidget extends StatefulWidget {
  final TreeNodeModel treeNode;
  final double indent;
  const TreeNodeWidget({super.key, required this.treeNode, this.indent = 0});

  @override
  State<TreeNodeWidget> createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  @override
  Widget build(BuildContext context) {
    TreeNodeModel treeNode = widget.treeNode;
    bool hasChildren = treeNode.children.isNotEmpty;
    String leadingIcon = treeNode.node is AssetModel
        ? (treeNode.node as AssetModel).getLeadingIcon()
        : AppImages.pin;
    String? trailingIcon = treeNode.node is AssetModel
        ? (treeNode.node as AssetModel).getTrailingIcon()
        : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: widget.indent),
          onTap: () {
            var treeNode = widget.treeNode;
            setState(() {
              treeNode.isExpanded = !treeNode.isExpanded;
            });
          },
          leading: hasChildren
              ? Icon(
                  treeNode.isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: !hasChildren ? Colors.grey.shade400 : null,
                )
              : const SizedBox(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(leadingIcon),
              const SizedBox(width: 8), // Espaço entre o ícone e o texto
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100),
                        child: Text(
                          widget.treeNode.title,
                        ),
                      ),
                    ),
                    trailingIcon != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              SvgPicture.asset(trailingIcon),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (hasChildren && treeNode.isExpanded)
          ...widget.treeNode.children.map(
            (e) => TreeNodeWidget(treeNode: e, indent: widget.indent + 20),
          )
      ],
    );
  }
}
