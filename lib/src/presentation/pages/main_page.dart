import 'package:flutter/material.dart';
import 'package:menu_task/src/core/models/models.dart' show Menu;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Menu> menuItems = [
    Menu(icon: Icons.home, title: "Home"),
    Menu(icon: Icons.search, title: "Search"),
    Menu(icon: Icons.message, title: "Messages"),
    Menu(icon: Icons.person, title: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Selected: ${menuItems[_selectedIndex].title}"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: menuItems.length <= 4
              ? menuItems.map((item) => _buildBottomBarItem(item)).toList()
              : List<Widget>.from(menuItems
                      .take(4)
                      .map((item) => _buildBottomBarItem(item))) +
                  [_buildMoreButton(menuItems.skip(4).toList())],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < 0) {
            //
          }
        },
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 2.0,
          child: const Icon(Icons.add, size: 30.0),
        ),
      ),
    );
  }

  Widget _buildBottomBarItem(Menu item) {
    return IconButton(
      icon: Icon(item.icon, color: Colors.white),
      onPressed: () {
        setState(() {
          _selectedIndex = menuItems.indexOf(item);
        });
      },
    );
  }

  Widget _buildMoreButton(List<Menu> remainingItems) {
    return PopupMenuButton<Menu>(
      icon: const Icon(Icons.more_horiz, color: Colors.white),
      onSelected: (Menu result) {
        setState(() {
          _selectedIndex = menuItems.indexOf(result);
        });
      },
      itemBuilder: (BuildContext context) => remainingItems
          .map((Menu item) => PopupMenuItem(
                value: item,
                child: Text(item.title),
              ))
          .toList(),
    );
  }
}
