import 'package:flutter/material.dart';

class MenuItemsPage extends StatelessWidget {
  final String day;
   MenuItemsPage({required this.day});


  Map<String, List<String>> menuItems = {
    'Sunday': ['MACRONI', 'BIRIYANI', 'AVIL','PARTS CURRY'],
    'Monday': ['STEAM CAKE', 'FISH FRY', 'NEYYAPPAM','SOYABEAN'],
    'Tuesday': ['DOSA & EGG', 'PAPPADAM', 'KADALA ROAST','GHEE RICE & CHICKEN'],
    'Wednesday': ['CHAPATHI', 'PAPPADAM & SAMBAR', 'PAZHAM PORI','PUSHKA'],
    'Thursday': ['IDLI', 'PULIYINCHI', 'UZHUNNU VADA','EGG BURJI'],
    'Friday': ['PUSHKA', 'BEEF', 'JUICE','PARIPPU'],
    'Saturday': ['POROTTA', 'FISH CURRY', 'SUGEENA','CAULIFLOWER'],
  };

  @override
  Widget build(BuildContext context) {
    List<String> items = menuItems[day] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu for $day'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            // Add more details or customize UI for each menu item here
          );
        },
      ),
    );
  }
}