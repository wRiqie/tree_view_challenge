class TreeNodeModel<T> {
  final T node;
  final String title;
  bool isExpanded;
  List<TreeNodeModel> children;

  TreeNodeModel({
    required this.node,
    required this.title,
    this.isExpanded = false,
  }) : children = [];

  TreeNodeModel<T> copyWith({
    T? node,
    String? title,
    bool? isExpanded,
    List<TreeNodeModel>? children,
  }) {
    return TreeNodeModel<T>(
      node: node ?? this.node,
      title: title ?? this.title,
      isExpanded: isExpanded ?? this.isExpanded,
    )..children = children ?? this.children;
  }
}
