// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../data/food_data.dart'; // To get full item details if needed

class CartScreen extends StatelessWidget {
  final Map<String, int> cartItemsQuantities; // Item ID and its quantity
  final double totalCartPrice;

  const CartScreen({
    Key? key,
    required this.cartItemsQuantities,
    required this.totalCartPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get full FoodItem details for items in cart
    final List<FoodItem> itemsInCart = [];
    cartItemsQuantities.forEach((itemId, quantity) {
      if (quantity > 0) { // Only add items that have quantity > 0
        final item = allMockFoodItems.firstWhere(
              (food) => food.id == itemId,
          orElse: () => FoodItem(id: 'error', name: 'Error Item', imageUrl: '', price: 0, category: 'Error'),
        );
        if (item.id != 'error') {
          itemsInCart.add(item);
        }
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          title: const Text(
            "سلة التسوق", // Shopping Cart
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 22),
            onPressed: () {
              Navigator.pop(context); // Go back to CategoriesScreen
            },
          ),
        ),
        body: itemsInCart.isEmpty
            ? const Center(
          child: Text(
            "سلتك فارغة!", // Your cart is empty!
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: itemsInCart.length,
          itemBuilder: (context, index) {
            final item = itemsInCart[index];
            final quantity = cartItemsQuantities[item.id] ?? 0;
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 1.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    item.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) => const Icon(Icons.broken_image, size: 60),
                  ),
                ),
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textDirection: TextDirection.ltr,
                ),
                subtitle: Text(
                  'الكمية: $quantity  |  السعر: \$${(item.price * quantity).toStringAsFixed(2)}', // Quantity: | Price:
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  textDirection: TextDirection.rtl, // RTL for the whole subtitle
                ),
                trailing: Text(
                  '\$${item.price.toStringAsFixed(2)} للقطعة', // per piece
                  style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.w500),
                  textDirection: TextDirection.ltr, // LTR for price per piece
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: itemsInCart.isEmpty
            ? null
            : Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي: \$${totalCartPrice.toStringAsFixed(2)}', // Total:
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                // textDirection explicitly set to LTR for the dollar sign and number,
                // but overall context from Directionality widget makes the Arabic word "الإجمالي" appear first.
                textDirection: TextDirection.ltr,
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement checkout logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('جاري معالجة الطلب...')), // Processing order...
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("إتمام الشراء", style: TextStyle(color: Colors.white)), // Proceed to Checkout
              ),
            ],
          ),
        ),
      ),
    );
  }
}
