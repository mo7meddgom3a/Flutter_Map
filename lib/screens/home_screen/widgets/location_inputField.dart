import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';

class LocationInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isActive;
  final VoidCallback onToggleMapTapMode;
  final Function(Location) onSuggestionSelected;

  const LocationInputField({super.key,
    required this.controller,
    required this.hintText,
    required this.isActive,
    required this.onToggleMapTapMode,
    required this.onSuggestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Location>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.map),
            color: isActive ? Colors.green : Colors.black,
            onPressed: onToggleMapTapMode,
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) return [];
        try {
          return await locationFromAddress(pattern);
        } catch (e) {
          return [];
        }
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text('${suggestion.latitude}, ${suggestion.longitude}'),
        );
      },
      onSuggestionSelected: onSuggestionSelected,
    );
  }
}
