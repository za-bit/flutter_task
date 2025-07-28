// lib/data/food_data.dart
import '../models/food_item.dart';

const String bestOffersCategory = "أفضل العروض";
const String importedCategory = "مستورد";
const String spreadableCheeseCategory = "أجبان قابلة للدهن";
const String cheeseCategory = "أجبان";
const String bakeryCategory = "مخبوزات";
const String drinksCategory = "مشروبات";

final List<FoodItem> allMockFoodItems = [
  // === Best Offers (Focus on Burgers) ===
  FoodItem(
    id: 'f1',
    name: 'Double Whopper',
    imageUrl: 'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 12.99,
    category: bestOffersCategory,
  ),
  FoodItem(
    id: 'f2',
    name: 'Steakhouse XL Burger',
    imageUrl: 'https://images.pexels.com/photos/2271107/pexels-photo-2271107.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 15.50,
    category: bestOffersCategory,
  ),
  FoodItem(
    id: 'f3',
    name: 'Classic Steakhouse',
    imageUrl: 'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 10.75,
    category: bestOffersCategory,
  ),
  FoodItem(
    id: 'f4',
    name: 'Angus Beef Deluxe',
    imageUrl: 'https://images.pexels.com/photos/327158/pexels-photo-327158.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 14.20,
    category: bestOffersCategory,
  ),
  FoodItem(
    id: 'f5',
    name: 'Spicy Chicken King',
    imageUrl: 'https://images.pexels.com/photos/2725744/pexels-photo-2725744.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 9.75,
    category: bestOffersCategory,
  ),
  FoodItem(
    id: 'f6',
    name: 'Mushroom Swiss Melt',
    imageUrl: 'https://images.pexels.com/photos/2092916/pexels-photo-2092916.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 11.50,
    category: bestOffersCategory,
  ),
  FoodItem(
    id: 'f30',
    name: 'BBQ Bacon Burger',
    imageUrl: 'https://images.pexels.com/photos/1556698/pexels-photo-1556698.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 13.00,
    category: bestOffersCategory,
  ),
  FoodItem(
    id: 'f31',
    name: 'Veggie Supreme Burger',
    imageUrl: 'https://images.pexels.com/photos/1108117/pexels-photo-1108117.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 8.99,
    category: bestOffersCategory,
  ),
  FoodItem(
    id: 'f32',
    name: 'Big King XL',
    imageUrl: 'https://images.pexels.com/photos/3616956/pexels-photo-3616956.jpeg?auto=compress&cs=tinysrgb&w=600', // Generic meal, but can be a big burger
    price: 16.00,
    category: bestOffersCategory,
  ),
  // === Other Categories (keep them varied for scrolling) ===
  // Imported
  FoodItem(
    id: 'f8',
    name: 'Belgian Chocolate Assortment',
    imageUrl: 'https://images.pexels.com/photos/4110101/pexels-photo-4110101.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 18.00,
    category: importedCategory,
  ),
  FoodItem(
    id: 'f9',
    name: 'Italian Organic Pasta',
    imageUrl: 'https://images.pexels.com/photos/1487511/pexels-photo-1487511.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 5.20,
    category: importedCategory,
  ),
  // ... (add more items for other categories as in the previous example to ensure good scrolling)
  // Spreadable Cheese
  FoodItem(
    id: 'f12',
    name: 'Original Cream Cheese Spread',
    imageUrl: 'https://images.pexels.com/photos/5848291/pexels-photo-5848291.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 3.99,
    category: spreadableCheeseCategory,
  ),
  // Cheese
  FoodItem(
    id: 'f15',
    name: 'Aged Cheddar Block (250g)',
    imageUrl: 'https://images.pexels.com/photos/51311/pexels-photo-51311.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 7.00,
    category: cheeseCategory,
  ),
  // Bakery
  FoodItem(
    id: 'f19',
    name: 'Fresh Croissants (Pack of 4)',
    imageUrl: 'https://images.pexels.com/photos/2135/food-france-morning-breakfast.jpg?auto=compress&cs=tinysrgb&w=600',
    price: 5.00,
    category: bakeryCategory,
  ),
  // Drinks
  FoodItem(
    id: 'f21',
    name: 'Fresh Orange Juice (1L)',
    imageUrl: 'https://images.pexels.com/photos/338713/pexels-photo-338713.jpeg?auto=compress&cs=tinysrgb&w=600',
    price: 3.00,
    category: drinksCategory,
  ),
  // Add 10-15 more diverse items from previous examples here for other categories...
  FoodItem(id: 'f23', name: 'Gourmet Coffee Beans (250g)', imageUrl: 'https://images.pexels.com/photos/3737594/pexels-photo-3737594.jpeg?auto=compress&cs=tinysrgb&w=600', price: 12.99, category: importedCategory),
  FoodItem(id: 'f24', name: 'Artisan Baguette', imageUrl: 'https://images.pexels.com/photos/1387070/pexels-photo-1387070.jpeg?auto=compress&cs=tinysrgb&w=600', price: 3.50, category: bakeryCategory),
  FoodItem(id: 'f25', name: 'Extra Virgin Olive Oil (500ml)', imageUrl: 'https://images.pexels.com/photos/660282/pexels-photo-660282.jpeg?auto=compress&cs=tinysrgb&w=600', price: 9.75, category: importedCategory),
  FoodItem(id: 'f26', name: 'Plain Yogurt Tub (500g)', imageUrl: 'https://images.pexels.com/photos/5965943/pexels-photo-5965943.jpeg?auto=compress&cs=tinysrgb&w=600', price: 2.99, category: cheeseCategory),
  FoodItem(id: 'f27', name: 'Chocolate Chip Cookies (Pack of 6)', imageUrl: 'https://images.pexels.com/photos/2067396/pexels-photo-2067396.jpeg?auto=compress&cs=tinysrgb&w=600', price: 4.50, category: bakeryCategory),
  FoodItem(id: 'f28', name: 'Iced Coffee Latte', imageUrl: 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=600', price: 3.75, category: drinksCategory),
  FoodItem(id: 'f29', name: 'Blue Cheese Wedge', imageUrl: 'https://images.pexels.com/photos/4059090/pexels-photo-4059090.jpeg?auto=compress&cs=tinysrgb&w=600', price: 7.50, category: cheeseCategory),

];
