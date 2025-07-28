# flutter_task

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## AI Assistant
Gemini in Android Studio was used to assist in generating parts of the UI code, due to ProxyAI issues.
## 📱 Features

- Custom `AppBar` titled **"التصنيفات"**
- GridView with multiple food item cards
- Each food card contains:
    - Image of the food item
    - Name
    - Price
    - Add (+) / Remove (−) buttons
- Icon buttons for:
    - 🔍 Search (UI ready, not functional in current version)
    - 🛒 View cart (UI ready, not functional in current version)
    - 🔙 Back navigation (currently not functional)

---

## 🛠️ Technologies Used

- Flutter SDK
- Dart
- Android Studio
- Gemini AI Assistant (for code generation)

---

## 🔄 Data

- The app uses **static sample data** for the food items.
- No backend or Firebase is used in this version.

---

## 🚫 Limitations

- Buttons like **Search**, **Back**, and **Cart** are part of the UI but currently **not implemented**.
- Data is **hardcoded** and does not come from an external API or database.

---

## 🧠 Notes

> The UI code was partially generated using **Gemini (in Android Studio)**, due to technical issues encountered with ProxyAI.

---

## 👩‍💻 Developer

- Name: Zahret El-Islam
- Position Applied: Mobile Developer
- Date: July 2025

---

## Prompt Used


    Create a Flutter mobile screen using clean project structure with these folders:

        screens/

        models/

        data/

    Screen: Categories Page
    1. AppBar:

        Title centered: "التصنيفات" in bold.

        Background color: white.

        Left icon: Back arrow, should be functional (e.g., Navigator.pop()).

        Right icon: Search icon, also functional (e.g., opens a dummy SearchPage or prints to console).

        The AppBar should have no shadow.

        Layout direction is RTL.

    2. Horizontal Category Bar (below AppBar):

        A scrollable row with Arabic categories:

            "أفضل العروض", "مستورد", "أجبان قابلة للدهن", "أجبان"

        The active item is in green with underline or bold.

        Other items are in grey.

        When tapping a category, it should update the content accordingly (filtering or highlighting).

    3. Main Body - GridView:

        Use a 2-column GridView.builder to show food cards.

        Each card contains:

            Image (from network), should be visible and work correctly (no broken links).

            English item name (e.g., “Double Whopper”).

            English item price (e.g., “$15.00”).

            A row with + / – icons inside circular buttons to adjust quantity.

        Ensure images are correctly loaded and displayed.

        The “أفضل العروض” tab should include burger offers like Double Whopper, Steakhouse XL, Steakhouse as in the sample image.

        The GridView should allow infinite scroll (no limit on items shown).

    4. Bottom Navigation Bar:

        White background.

        Right side: Arabic text "عرض السلة".

        Left side: English price (e.g., "$45.00").

        Proper padding and font size.

    5. Visual Styling:

        Background color: #F5F5F5 (light grey).

        Cards: white background, rounded corners, proper padding and spacing.

        Use margin between GridView items and screen edges.

        Respect RTL direction in all layout.

        Use English for product names/prices and Arabic for UI elements.

    6. Folder structure:

        models/food_item.dart: define FoodItem with name, imageUrl, price.

        data/food_data.dart: list of dummy FoodItem objects with working image URLs.

        screens/categories_screen.dart: implement full UI.

    Notes:

        Make sure both back arrow and search icons work.

        Use proper spacing, clean layout.

        All images must be valid and display correctly.

        GridView should load more items on scroll if available


Create a Flutter mobile screen for the "التصنيفات" page with the following improvements and structure:
🔧 Project Structure:

        models/food_item.dart: defines class FoodItem with fields: name, imageUrl, price.

        data/food_data.dart: contains a long List<FoodItem> with real working image URLs (especially for burger items like "Double Whopper", "Steakhouse XL", "Steakhouse").

        screens/categories_screen.dart: full UI as described below.

    🧩 Screen Layout:
    1. AppBar:

        Title: "التصنيفات", centered, bold.

        Left icon: Back arrow → when pressed, should navigate back using Navigator.pop(context).

        Right icon: Search icon → when pressed, should show a print like print("Search clicked").

        Background: white, no elevation.

        Layout: RTL.

    2. Category Bar:

        Horizontally scrollable row with Arabic categories:
        "أفضل العروض", "مستورد", "أجبان قابلة للدهن", "أجبان".

        Active item in green & underlined, others in grey.

        Clicking on "أفضل العروض" should show more burger offers from the list (don't limit to few items).

    3. GridView of Items:

        Use GridView.builder with 2 columns.

        Each card shows:

            A working image at the top (from the FoodItem URL).

            Product name (in English).

            Price (e.g. "$15.00").

            Row with + and – buttons to add/remove quantity.

        Use dummy long list with various burgers and other items.

    4. Bottom Navigation Bar:

        Background: white.

        Right side: Arabic text "عرض السلة" → when pressed, prints: print("عرض السلة clicked").

        Left side: total price in English like "$45.00".

        Layout fits mobile screen nicely.

    5. Styling:

        Whole screen background: light grey #F5F5F5.

        Cards: white, rounded corners, spaced.

        Support RTL layout.

        Make sure all images work and show correctly.

        No limit to how many offers/items shown. User can scroll down to load more.

    ✅ Final Notes:

        Back button should work.

        Search icon should respond.

        "عرض السلة" should respond.

        All images must appear correctly.

        Make sure burger offers appear clearly under "أفضل العروض".

Thanks for the code, but I found some issues:

    The Back button doesn't work. It should navigate back using Navigator.pop(context).

    The Search icon does nothing. It should print "Search clicked" to the console when tapped.

    The "عرض السلة" button at the bottom also does nothing. It should print "عرض السلة clicked" when pressed.

Please fix these three issues. Thanks

## ✅ How to Run

1. Clone the repo or copy the project folder into your local machine.
2. Open with **Android Studio**.
3. Run with an emulator or real device using:

```bash
flutter run
