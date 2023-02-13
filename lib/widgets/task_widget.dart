import 'package:bounce_tap/bounce_tap.dart';
import 'package:flutter/material.dart';
import 'package:mac_os_ui/constants.dart';

import '../data/models/task.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  bool isHover = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = Tween<double>(begin: 1, end: 1.04).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) {
          animationController.forward();
          isHover = true;
        },
        onExit: (_) {
          animationController.reverse();
          isHover = false;
        },
        child: BounceTap(
          onTap: () {},
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, .001)
                  ..scale(animation.value),
                child: Container(
                  height: 120,
                  width: 200,
                  margin: const EdgeInsets.all(AppConstants.vPadding * 2),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppConstants.radius / 2),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.task.image),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -4,
                left: 12,
                child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius / 2),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.task.icon),
                      ),
                    )),
              )
            ],
          ),
        ),
      );
}
