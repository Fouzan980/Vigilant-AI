import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(hintText: 'Select category'),
      initialValue: selectedCategory,
      onChanged: onChanged,
      items: const [
        DropdownMenuItem<String>(
          enabled: false,
          child: Text(
            'CRIMES',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Theft and Robbery',
          child: Text('Theft and Robbery'),
        ),
        DropdownMenuItem(
          value: 'Assault and Violence',
          child: Text('Assault and Violence'),
        ),
        DropdownMenuItem(
          value: 'Vandalism and Graffiti',
          child: Text('Vandalism and Graffiti'),
        ),
        DropdownMenuItem<String>(
          enabled: false,
          child: Text(
            'INFRASTRUCTURE',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Pothole and Road Damage',
          child: Text('Pothole and Road Damage'),
        ),
        DropdownMenuItem(
          value: 'Broken Street Light',
          child: Text('Broken Street Light'),
        ),
        DropdownMenuItem<String>(
          enabled: false,
          child: Text(
            'WEATHER AND HAZARDS',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Flooding and Waterlogging',
          child: Text('Flooding and Waterlogging'),
        ),
        DropdownMenuItem(
          value: 'Fire and Smoke Sighted',
          child: Text('Fire and Smoke Sighted'),
        ),
      ],
    );
  }
}
