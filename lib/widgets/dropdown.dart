import 'package:flutter/material.dart';

class MusicDropdownMenu extends StatelessWidget {
  final List<DropdownMenuEntry<dynamic>> dropdownMenuEntries;
  final dynamic initialSelection;
  final void Function(dynamic)? onSelected;
  final Widget? label;

  // Constant Values
  final bool enableSearch = false;
  final bool enableFilter = false;

  const MusicDropdownMenu({
    super.key,
    this.initialSelection,
    this.label,
    this.onSelected,
    required this.dropdownMenuEntries
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: dropdownMenuEntries,
      label: label,
      onSelected: onSelected,
      initialSelection: initialSelection,
      enableFilter: enableFilter,
      enableSearch: enableSearch,
    );
  }
}