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
    Menu(icon: Icons.mail, title: "Mail"),
    Menu(icon: Icons.voice_chat, title: "Chat"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Selected: ${menuItems[_selectedIndex].title}"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: menuItems.length <= 4
              ? menuItems.map((item) => _buildBottomBarItem(item)).toList()
              : List<Widget>.from(menuItems
                      .take(3)
                      .map((item) => _buildBottomBarItem(item))) +
                  [_buildMoreButton(menuItems.skip(3).toList())],
        ),
      ),
    );
  }

  Widget _buildBottomBarItem(Menu item) {
    return IconButton(
      icon: Icon(item.icon, color: Colors.purple),
      onPressed: () {
        setState(() {
          _selectedIndex = menuItems.indexOf(item);
        });
      },
    );
  }

  Widget _buildMoreButton(List<Menu> remainingItems) {
    return PopupMenuButton<Menu>(
      icon: const Icon(Icons.more_horiz, color: Colors.purple),
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

  Widget _buildFloatingActionButton() {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < 0) {
          //
        }
      },
      child: FloatingActionButton(
        onPressed: () {},
        elevation: 2.0,
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add, size: 30.0),
      ),
    );
  }
}
