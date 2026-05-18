import 'package:flutter/material.dart';

class DistrictDropdown extends StatefulWidget {
  final String? selectedDistrict;
  final ValueChanged<String?> onChanged;

  const DistrictDropdown({
    super.key,
    this.selectedDistrict,
    required this.onChanged,
  });

  @override
  State<DistrictDropdown> createState() => _DistrictDropdownState();
}

class _DistrictDropdownState extends State<DistrictDropdown> {
  final List<String> districts = [
    'Downtown',
    'Northside',
    'Southside',
    'West End',
    'East Side',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.selectedDistrict ?? districts.first,
      onSelected: widget.onChanged,
      dropdownMenuEntries: districts.map<DropdownMenuEntry<String>>((
        String value,
      ) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
