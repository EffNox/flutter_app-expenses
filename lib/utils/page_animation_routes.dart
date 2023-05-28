import 'package:flutter/material.dart';

class PageAnimationRoute extends PageRouteBuilder {
  final Widget widget;

  PageAnimationRoute({required this.widget})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (
            BuildContext _,
            Animation<double> anm,
            Animation<double> __,
            Widget child,
          ) {
            anm = CurvedAnimation(parent: anm, curve: Curves.easeOutBack);
            return ScaleTransition(
              scale: anm,
              alignment: const Alignment(0.8, 0.8),
              child: child,
            );
          },
          pageBuilder: (
            BuildContext _,
            Animation<double> animation,
            Animation<double> __,
          ) =>
              widget,
        );
}
