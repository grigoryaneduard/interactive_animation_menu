import 'package:flutter/material.dart';
import 'package:menu_task/src/core/models/models.dart' show Menu;

class MenuPage extends StatelessWidget {
  final List<Menu> menuItems;

  const MenuPage({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(menuItems[index].icon),
            title: Text(menuItems[index].title),
          );
        },
      ),
    );
  }
}