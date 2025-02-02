import 'package:batchiq_app/core/colors/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabel;
  final String hintText;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.itemLabel,
    this.hintText = 'Select an option',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      hint: Text(
        hintText,
        style: TextStyle(
          color: secondaryFontColor.withOpacity(0.9),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      value: selectedValue,
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
          value: item,
          child: Text(
            itemLabel(item),
            style: TextStyle(
              color: secondaryFontColor.withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select an option.';
        }
        return null;
      },
      onChanged: onChanged,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
