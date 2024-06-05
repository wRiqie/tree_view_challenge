extension StringListExt on List<String> {
  String concatenateWithSpace() {
    String text = '';
    for (var e in this) {
      text += e;
      if (indexOf(e) < (length - 1)) {
        text += ' ';
      }
    }
    return text;
  }
}

extension ListExt<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension MapExt<K, V> on Map<K, V> {
  void addAllNotNull(Map<K, V> map) {
    for (var entry in map.entries) {
      if (entry.value != null) {
        addAll({entry.key: entry.value});
      }
    }
  }
}
