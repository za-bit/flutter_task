// lib/widgets/category_bar_item.dart
import 'package:flutter/material.dart';

class CategoryBarItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const CategoryBarItem({
    Key? key,
    required this.title,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.green.shade700 : Colors.grey.shade600,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 15,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                height: 2.5,
                width: 30, // Width of the underline
                color: Colors.green.shade700,
              ),
          ],
        ),
      ),
    );
  }
}