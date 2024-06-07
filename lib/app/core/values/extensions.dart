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

extension MapExt<K, V> on Map<K, V> {
  void addAllNotNull(Map<K, V> map) {
    for (var entry in map.entries) {
      if (entry.value != null) {
        addAll({entry.key: entry.value});
      }
    }
  }
}
