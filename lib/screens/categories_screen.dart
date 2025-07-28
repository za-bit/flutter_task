// lib/screens/categories_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemNavigator
import '../models/food_item.dart';
import '../data/food_data.dart';
import '../widgets/category_bar_item.dart';
import '../widgets/quantity_adjust_buttons.dart';
import 'cart_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<String> _categoryBarTitles = [
    bestOffersCategory,
    importedCategory,
    spreadableCheeseCategory,
    cheeseCategory,
    bakeryCategory,
    drinksCategory,
  ];
  int _selectedCategoryIndex = 0;

  List<FoodItem> _allFoodItemsForSelectedCategory = []; // Holds all items for the current category
  List<FoodItem> _displayedFoodItems = []; // Items currently shown (can be filtered)
  Map<String, int> _itemQuantities = {};
  double _totalCartPrice = 0.0;

  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _currentMaxItems = 10;
  final int _itemsIncrement = 10;

  // --- NEW Search State Variables ---
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  // --- END NEW Search State Variables ---

  @override
  void initState() {
    super.initState();
    _loadItemsForSelectedCategory(); // Load all items for the category first
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        _applySearchFilter(); // Apply filter as user types
      });
    });
    _scrollController.addListener(_onScroll);
    _updateCartTotal();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose(); // Dispose the controller
    super.dispose();
  }

  void _onScroll() {
    if (!_isSearching && // Only load more if not currently searching (or adjust logic as needed)
        _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMorePaginatedItems();
    }
  }

  // Renamed and adjusted to load all items for the category, then paginate/filter from this list
  void _loadItemsForSelectedCategory() {
    setState(() {
      _isLoadingMore = true; // Indicate loading
      _allFoodItemsForSelectedCategory.clear();
      _displayedFoodItems.clear();
      _currentMaxItems = _itemsIncrement; // Reset for pagination
    });

    final selectedCategoryName = _categoryBarTitles[_selectedCategoryIndex];
    // Simulate fetching all items for the category
    Future.delayed(const Duration(milliseconds: 100), () { // Shorter delay for initial full list load
      _allFoodItemsForSelectedCategory = allMockFoodItems
          .where((item) => item.category == selectedCategoryName)
          .toList();
      _applySearchFilter(); // This will also handle initial pagination
    });
  }


  // Applies search and pagination
  void _applySearchFilter() {
    List<FoodItem> filteredItems;
    if (_searchQuery.isEmpty) {
      filteredItems = List.from(_allFoodItemsForSelectedCategory); // No search, use all items from category
    } else {
      filteredItems = _allFoodItemsForSelectedCategory
          .where((item) => item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    setState(() {
      // If searching, show all results of search, no pagination for simplicity here
      // Or, you could paginate search results too if desired.
      if(_searchQuery.isNotEmpty){
        _displayedFoodItems = filteredItems;
      } else {
        // Paginate if not searching
        _displayedFoodItems = filteredItems.take(_currentMaxItems).toList();
      }
      _isLoadingMore = false; // Done loading/filtering
    });
  }


  // Renamed to reflect it's for pagination
  void _loadMorePaginatedItems() {
    if (_isLoadingMore || _searchQuery.isNotEmpty) return; // Don't paginate if already loading or if searching

    // Check if all items for the category (without search) are already displayed
    if (_displayedFoodItems.length >= _allFoodItemsForSelectedCategory.length) {
      setState(() { _isLoadingMore = false; });
      return;
    }

    setState(() { _isLoadingMore = true; });

    Future.delayed(const Duration(milliseconds: 500), () {
      _currentMaxItems += _itemsIncrement;
      // Get the next chunk of items from the full category list
      _displayedFoodItems = _allFoodItemsForSelectedCategory.take(_currentMaxItems).toList();
      setState(() {
        _isLoadingMore = false;
      });
    });
  }


  void _selectCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _searchController.clear(); // Clear search when category changes
      _isSearching = false; // Exit search mode
      _loadItemsForSelectedCategory(); // Reload items for the newly selected category
    });
  }

  void _incrementQuantity(String itemId) {
    setState(() {
      _itemQuantities[itemId] = (_itemQuantities[itemId] ?? 0) + 1;
      _updateCartTotal();
    });
  }

  void _decrementQuantity(String itemId) {
    setState(() {
      if (_itemQuantities.containsKey(itemId) && _itemQuantities[itemId]! > 0) {
        _itemQuantities[itemId] = _itemQuantities[itemId]! - 1;
        _updateCartTotal();
      }
    });
  }

  void _updateCartTotal() {
    double total = 0;
    _itemQuantities.forEach((itemId, quantity) {
      final item = allMockFoodItems.firstWhere((food) => food.id == itemId,
          orElse: () => FoodItem(id: 'error', name: 'Error', imageUrl: '', price: 0, category: 'Error'));
      if (item.id != 'error') {
        total += item.price * quantity;
      }
    });
    setState(() { _totalCartPrice = total; });
  }

  void _onAppBarBackPressed() {
    // If searching, pressing back should close search first
    if (_isSearching) {
      setState(() {
        _isSearching = false;
        _searchController.clear(); // Clears text and triggers listener to reload full list
        // _applySearchFilter(); // Already called by listener
      });
    } else {
      SystemNavigator.pop();
    }
  }

  // --- MODIFIED Search Action ---
  void _handleSearchSubmit(String query) {
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال اسم المنتج للبحث', textDirection: TextDirection.rtl)),
      );
      return;
    }
    print("Searching for: $query");
    _applySearchFilter(); // Apply the filter based on the submitted query

    // Check if results are empty after filtering
    // Add a small delay for the UI to update with filtered results
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_displayedFoodItems.isEmpty && query.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"$query" المنتج غير موجود', textDirection: TextDirection.rtl)),
        );
      }
    });
  }
  // --- END MODIFIED Search Action ---


  void _onViewCartPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItemsQuantities: _itemQuantities,
          totalCartPrice: _totalCartPrice,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      cursorColor: Colors.green.shade700,
      decoration: InputDecoration(
        hintText: "ابحث عن منتج...", // Search for a product...
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        // Optional: Add a clear button
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
          icon: Icon(Icons.clear, color: Colors.grey.shade600, size: 20),
          onPressed: () {
            _searchController.clear(); // This will trigger the listener to reload
          },
        )
            : null,
      ),
      style: const TextStyle(color: Colors.black87, fontSize: 16.5),
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.search,
      onSubmitted: _handleSearchSubmit, // Handle search on keyboard action
    );
  }

  @override
  Widget build(BuildContext context) {
    // Using WillPopScope to handle Android back button press when search is active
    return WillPopScope(
      onWillPop: () async {
        if (_isSearching) {
          setState(() {
            _isSearching = false;
            _searchController.clear();
            // _applySearchFilter(); // Listener will handle this
          });
          return false; // Prevent default back navigation
        }
        return true; // Allow default back navigation (app exit)
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: _isSearching ? 0.5 : 0, // Slight elevation when searching for separation
            centerTitle: _isSearching ? false : true, // Center title only when not searching
            leadingWidth: _isSearching ? 40 : 56, // Adjust width for back button when searching
            leading: _isSearching
                ? IconButton( // Show a close button for search field
              icon: Icon(Icons.close, color: Colors.black54, size: 24),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                  // _applySearchFilter(); // Listener will handle this
                });
              },
            )
                : IconButton( // Original back button for app exit
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 22),
              onPressed: _onAppBarBackPressed,
            ),
            title: _isSearching
                ? _buildSearchField()
                : const Text("التصنيفات", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
            actions: _isSearching
                ? [ // Optionally, add a search confirm button if onSubmitted is not enough
              // IconButton(
              //   icon: Icon(Icons.search, color: Colors.green.shade700, size: 26),
              //   onPressed: () => _handleSearchSubmit(_searchController.text),
              // ),
              // const SizedBox(width: 8),
            ]
                : [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black54, size: 26),
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Column(
            children: [
              // Category Bar
              if (!_isSearching) // Hide category bar when searching
                Container(
                  height: 55,
                  color: Colors.white,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: _categoryBarTitles.length,
                    itemBuilder: (context, index) {
                      return CategoryBarItem(
                        title: _categoryBarTitles[index],
                        isActive: index == _selectedCategoryIndex,
                        onTap: () => _selectCategory(index),
                      );
                    },
                  ),
                ),
              if (_isSearching && _searchQuery.isEmpty && _displayedFoodItems.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      "ابدأ بكتابة اسم المنتج...", // Start typing product name...
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontFamily: 'Tajawal'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else if (_displayedFoodItems.isEmpty && (_isLoadingMore || _searchQuery.isNotEmpty)) // Show "not found" or "no items"
                Expanded(
                  child: Center(
                    child: Text(
                      _searchQuery.isNotEmpty
                          ? '"${_searchController.text}"\nالمنتج غير موجود' // "Product not found"
                          : 'لا توجد عناصر في هذا التصنيف حاليًا.', // "No items in this category currently"
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontFamily: 'Tajawal'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: _displayedFoodItems.length + (_isLoadingMore && _searchQuery.isEmpty ? 1 : 0), // Loader only if not searching & loading more
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.68),
                      itemBuilder: (ctx, index) {
                        if (_searchQuery.isEmpty && index == _displayedFoodItems.length && _isLoadingMore) {
                          return const Center(child: CircularProgressIndicator(strokeWidth: 3));
                        }
                        if (index >= _displayedFoodItems.length) { return const SizedBox.shrink(); }

                        final item = _displayedFoodItems[index];
                        final quantity = _itemQuantities[item.id] ?? 0;
                        return Card(
                          // ... (rest of the Card UI remains the same)
                          color: Colors.white, elevation: 1.5, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Image.network(
                                  item.imageUrl, fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(child: CircularProgressIndicator(strokeWidth: 2.0, value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null));
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(color: Colors.grey[200], child: Center(child: Icon(Icons.broken_image, color: Colors.grey[400], size: 40)));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 4.0),
                                child: Text(item.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5, color: Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis, textDirection: TextDirection.ltr),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text('\$${item.price.toStringAsFixed(2)}', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5, color: Colors.green.shade800), textDirection: TextDirection.ltr),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0, bottom: 10.0, left: 10.0, right: 10.0),
                                child: QuantityAdjustButtons(quantity: quantity, onIncrement: () => _incrementQuantity(item.id), onDecrement: () => _decrementQuantity(item.id)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: _isSearching ? null : Container( // Hide bottom bar when searching
            // ... (rest of BottomNavigationBar UI remains the same)
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), spreadRadius: 0, blurRadius: 6, offset: const Offset(0, -3))]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${_totalCartPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87), textDirection: TextDirection.ltr),
                ElevatedButton(
                  onPressed: _onViewCartPressed,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12), textStyle: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                  child: const Text("عرض السلة", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

