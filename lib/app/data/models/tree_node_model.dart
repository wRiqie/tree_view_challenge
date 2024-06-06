class TreeNodeModel<T> {
  final T node;
  List<TreeNodeModel> children;

  TreeNodeModel(this.node) : children = [];
}
