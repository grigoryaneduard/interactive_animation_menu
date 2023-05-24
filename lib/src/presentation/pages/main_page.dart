import 'package:flutter/material.dart';
import 'package:menu_task/src/core/models/models.dart' show Menu;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const maxDisplayItems = 4;

  final List<Menu> _menuItems = [
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
        child: Text("Selected: ${_menuItems[_selectedIndex].title}"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildBottomBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBottomBarItems() {
    var displayItems = _menuItems.length < maxDisplayItems
        ? _menuItems
        : _menuItems.take(maxDisplayItems);

    var items = [
      for (var item in displayItems) _buildBottomBarItem(item),
    ];

    if (_menuItems.length > maxDisplayItems) {
      items.last =
          _buildMoreButton(_menuItems.skip(maxDisplayItems - 1).toList());
    }

    var fabPosition = items.length >= 4 ? 2 : items.length;

    items.insert(fabPosition, _buildFloatingActionButton());

    return items;
  }

  Widget _buildBottomBarItem(Menu item) {
    return IconButton(
      icon: Icon(item.icon, color: Colors.purple),
      onPressed: () => _updateSelectedIndex(item),
    );
  }

  Widget _buildMoreButton(List<Menu> remainingItems) {
    return PopupMenuButton<Menu>(
      icon: const Icon(Icons.more_horiz, color: Colors.purple),
      onSelected: _updateSelectedIndex,
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
          // Code to execute when dragging up
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

  void _updateSelectedIndex(Menu item) {
    setState(() {
      _selectedIndex = _menuItems.indexOf(item);
    });
  }
}
