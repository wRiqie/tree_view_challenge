class TreeNodeModel<T> {
  final T node;
  final String title;
  List<TreeNodeModel> children;

  TreeNodeModel({
    required this.node,
    required this.title,
  }) : children = [];
}
