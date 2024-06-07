import 'dart:async';

import 'package:flutter/material.dart';

class SearchInputWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String query)? onSearch;
  const SearchInputWidget({
    super.key,
    required this.hintText,
    this.onSearch,
    required this.controller,
  });

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  late TextEditingController searchCtrl;
  bool isSearching = false;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    searchCtrl = widget.controller;
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchCtrl,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: widget.hintText,
        suffixIcon: isSearching
            ? IconButton(
                onPressed: () {
                  setState(() {
                    searchCtrl.clear();
                    isSearching = false;
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (widget.onSearch != null) widget.onSearch!('');
                  });
                },
                icon: const Icon(Icons.clear),
              )
            : null,
      ),
      onChanged: (value) {
        setState(() {
          isSearching = value.trim().isNotEmpty;
        });
        debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 600), () {
          if (widget.onSearch != null) widget.onSearch!(value);
        });
      },
    );
  }
}
