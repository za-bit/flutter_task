// lib/models/food_item.dart
class FoodItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;

  FoodItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
  });
}