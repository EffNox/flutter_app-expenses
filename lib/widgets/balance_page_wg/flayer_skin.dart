import 'package:flutter/material.dart';

class FlayerSkinWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  const FlayerSkinWidget({Key? key, required this.title, required this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 25),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 14, bottom: 6),
            width: size.width,
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, letterSpacing: 1.5),
            ),
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(30),
            ),
            child: widget,
          )
        ],
      ),
    );
  }
}
