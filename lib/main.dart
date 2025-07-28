// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/categories_screen.dart'; // Import your screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Categories RTL',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Tajawal', // Ensure this font is in pubspec.yaml and assets
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black54),
          actionsIconTheme: IconThemeData(color: Colors.black54),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.green,
        ),
      ),
      home: const CategoriesScreen(),
      // Example of how to add a route for the dummy search page if you don't pass it directly
      // routes: {
      //   '/search': (context) => const DummySearchPage(),
      // },
    );
  }
}