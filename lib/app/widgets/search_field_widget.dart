import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  const SearchFieldWidget({super.key, required this.controller});

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Buscar Ativo ou Local',
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  widget.controller.clear();
                },
                icon: const Icon(
                  Icons.clear,
                ),
              )
            : null,
      ),
    );
  }
}
