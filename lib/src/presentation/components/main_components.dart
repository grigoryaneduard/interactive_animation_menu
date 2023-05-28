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

  Text _textBuilder(String text) =>
      Text(text, style: const TextStyle(color: Colors.white, fontSize: 16));

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
                CircleButton(
                    onPressed: onPressed, icon: Icons.close, size: size)
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 140),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _textBuilder("Remainder"),
                _textBuilder("Camera"),
                _textBuilder("Attachment"),
                _textBuilder("Text Note"),
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
  final double size;
  final VoidCallback onPressed;

  const CircleButton(
      {Key? key,
      required this.icon,
      required this.size,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: RawMaterialButton(
            onPressed: onPressed,
            elevation: 0,
            fillColor: Colors.white,
            shape: const CircleBorder(),
            child: Icon(icon, color: Colors.blue)));
  }
}
