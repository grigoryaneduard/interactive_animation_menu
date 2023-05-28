import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final VoidCallback onPressed;
  final Animation<double> rotateAnimation;
  final double size;

  const FAB(
      {Key? key,
      required this.rotateAnimation,
      required this.onPressed,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < 0) {
            onPressed();
          }
        },
        child: SizedBox(
          width: size,
          height: size,
          child: FloatingActionButton(
              onPressed: onPressed,
              backgroundColor: Colors.blue,
              child: RotationTransition(
                  turns: rotateAnimation, child: const Icon(Icons.add))),
        ));
  }
}

class PopupMenu extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;

  const PopupMenu({Key? key, required this.size, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: onPressed,
                    enableFeedback: false,
                    child:
                        Container(color: Colors.red, height: size, width: size))
              ],
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 140),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Title 1"),
                Text("Title 2"),
                Text("Title 3"),
                Text("Title 4"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircleButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: Colors.blue,
        padding: const EdgeInsets.all(18.0),
        shape: const CircleBorder(),
        child: Icon(icon, color: Colors.white, size: 18));
  }
}
