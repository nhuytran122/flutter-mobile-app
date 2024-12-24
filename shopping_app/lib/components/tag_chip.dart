import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';

class TagChip extends StatelessWidget {
  final String tag;
  final bool isSelected;
  final Function(bool) onSelected;

  const TagChip({
    Key? key,
    required this.tag,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(tag),
        selected: isSelected,
        onSelected: onSelected,
        selectedColor: Colors.blue.shade100,
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primary : Colors.black,
        ),
      ),
    );
  }
}
