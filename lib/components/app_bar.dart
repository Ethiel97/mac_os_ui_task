import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mac_os_ui/constants.dart';
import 'package:mac_os_ui/data/models/app.dart';
import 'package:mac_os_ui/widgets/app_widget.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;
  Timer? timer;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation =
        Tween<Offset>(begin: const Offset(0, 3), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: animationController, curve: Curves.easeInOut));

    animationController.addListener(() {
      setState(() {});
    });
    super.initState();

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (timer != null && timer!.isActive) {
          timer?.cancel();
        }
        animationController.forward();
      },
      onExit: (_) {
        if (timer != null && timer!.isActive) {
          timer?.cancel();
        }
        /*else {*/
        timer = Timer(const Duration(seconds: 10), () {
          animationController.reverse();
        });
      },
      child: SlideTransition(
        position: animation,
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          padding: const EdgeInsets.all(AppConstants.vPadding),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.vPadding,
              horizontal: AppConstants.hPadding,
            ),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.02),
                borderRadius: BorderRadius.circular(AppConstants.radius),
                border: Border.all(
                  color: Colors.white.withOpacity(.6),
                  width: .35,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(.02),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  )
                ]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: apps
                    .mapIndexed(
                      (i, e) => Flexible(
                        child: AppWidget(
                          app: apps[i],
                        ),
                      ),
                    )
                    .toList()),
          ),
        ),
      ),
    );
  }
}
