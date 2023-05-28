import 'package:flutter/material.dart';
import 'package:menu_task/src/core/models/models.dart' show MenuModel;
import 'package:menu_task/src/presentation/components/main_components.dart';
import 'package:menu_task/src/presentation/constants/main_constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _rotateController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _rotateAnimation;

  int _selectedIndex = 0;
  static const maxDisplayItems = 4;

  final List<MenuModel> _menuItems = [
    MenuModel(id: 1, icon: Icons.home, title: "Home"),
    MenuModel(id: 2, icon: Icons.search, title: "Search"),
    MenuModel(id: 3, icon: Icons.message, title: "Messages"),
    MenuModel(id: 4, icon: Icons.person, title: "Profile"),
    MenuModel(id: 5, icon: Icons.mail, title: "Mail"),
    MenuModel(id: 6, icon: Icons.voice_chat, title: "Chat"),
  ];

  @override
  void initState() {
    super.initState();
    _initRotationAnimation();
    _initTransformAnimation();
  }

  void _initRotationAnimation() {
    _rotateController =
        AnimationController(vsync: this, duration: animationDuration);

    _rotateAnimation = Tween(begin: 0.0, end: 0.12).animate(_rotateController);
  }

  void _initTransformAnimation() {
    _controller = AnimationController(duration: animationDuration, vsync: this);

    _offsetAnimation = Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0.0, -(fabFactor[fabSize]?.toDouble() ?? 0)))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _onReverse() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    }
    if (_rotateController.status == AnimationStatus.completed) {
      _rotateController.reverse();
    }
  }

  void _onForward() {
    if (_rotateController.status == AnimationStatus.dismissed) {
      _rotateController.forward();
    }
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text("Events",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold)))
          ],
        ),
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
      for (var item in displayItems)
        _buildBottomBarItem(item, _menuItems[_selectedIndex].id == item.id),
    ];

    if (_menuItems.length > maxDisplayItems) {
      items.last =
          _buildMoreButton(_menuItems.skip(maxDisplayItems - 1).toList());
    }

    var fabPosition = items.length >= 4 ? 2 : items.length;

    items.insert(
        fabPosition,
        SlideTransition(
            position: _offsetAnimation,
            child: FAB(
                onPressed: _onForward,
                rotateAnimation: _rotateAnimation,
                size: fabSize)));

    return items;
  }

  Widget _buildBottomBarItem(MenuModel item, bool isActive) {
    return IconButton(
      icon:
          Icon(item.icon, color: isActive ? Colors.purple[900] : Colors.purple),
      onPressed: () => _updateSelectedIndex(item),
    );
  }

  Widget _buildMoreButton(List<MenuModel> remainingItems) {
    return PopupMenuButton<MenuModel>(
      icon: const Icon(Icons.more_horiz, color: Colors.purple),
      onSelected: _updateSelectedIndex,
      itemBuilder: (BuildContext context) => remainingItems
          .map((MenuModel item) => PopupMenuItem(
                value: item,
                child: Text(item.title),
              ))
          .toList(),
    );
  }

  void _updateSelectedIndex(MenuModel item) {
    setState(() {
      _selectedIndex = _menuItems.indexOf(item);
    });
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
