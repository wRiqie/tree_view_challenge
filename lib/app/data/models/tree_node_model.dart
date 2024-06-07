import 'package:flutter/material.dart';

class TreeNodeModel<T> {
  final T node;
  final Widget? leading;
  final Widget? trailing;
  final String title;
  List<TreeNodeModel> children;

  TreeNodeModel({
    required this.node,
    this.leading,
    this.trailing,
    required this.title,
  }) : children = [];
}
