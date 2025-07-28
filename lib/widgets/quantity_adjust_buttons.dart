// lib/widgets/quantity_adjust_buttons.dart
import 'package:flutter/material.dart';

class QuantityAdjustButtons extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final double iconSize;
  final double padding;

  const QuantityAdjustButtons({
    Key? key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.iconSize = 18.0, // Default icon size
    this.padding = 3.0,   // Default padding for the button container
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Keep buttons compact
      children: [
        _buildQuantityButton(
          icon: Icons.remove,
          color: Colors.redAccent.shade200,
          onPressed: onDecrement,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            quantity.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textDirection: TextDirection.ltr, // For the number itself
          ),
        ),
        _buildQuantityButton(
          icon: Icons.add,
          color: Colors.green.shade600,
          onPressed: onIncrement,
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20), // Makes the splash effect circular
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12), // Softer background for the button
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.5), width: 0.5), // Subtle border
        ),
        child: Icon(icon, color: color, size: iconSize),
      ),
    );
  }
}
