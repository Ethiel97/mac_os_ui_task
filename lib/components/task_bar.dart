import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mac_os_ui/constants.dart';
import 'package:mac_os_ui/data/models/task.dart';
import 'package:mac_os_ui/widgets/task_widget.dart';

class TaskBar extends StatefulWidget {
  const TaskBar({Key? key}) : super(key: key);

  @override
  State<TaskBar> createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    animation = Tween<double>(begin: -72, end: -16).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));

    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppConstants.vPadding),
        child: MouseRegion(
          onEnter: (_) {
            animationController.forward();
          },
          onExit: (_) {
            animationController.reverse();
          },
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, .001)
              ..rotateY((animation.value / 180) * pi),
            child: SizedBox(
              width: 200,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: tasks
                      .mapIndexed(
                        (i, e) => Flexible(
                          child: TaskWidget(task: tasks[i]),
                        ),
                      )
                      .toList()),
            ),
          ),
        ),
      );
}
