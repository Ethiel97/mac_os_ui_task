import 'package:bounce_tap/bounce_tap.dart';
import 'package:flutter/material.dart';
import 'package:mac_os_ui/constants.dart';
import 'package:mac_os_ui/data/models/app.dart';
import 'package:mac_os_ui/utils/text_styles.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    Key? key,
    required this.app,
  }) : super(key: key);
  final App app;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  bool isHover = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    animation = Tween<double>(begin: 1, end: 1.08).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(
            minWidth: 55,
            maxWidth: 80,
            minHeight: 55,
            maxHeight: 80,
          ),
          child: ScaleTransition(
            scale: animation,
            child: MouseRegion(
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
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.app.icon),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          curve: Curves.easeInOut,
          top: isHover ? -55 : -12,
          duration: const Duration(milliseconds: 300),
          child: AnimatedOpacity(
            opacity: isHover ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(AppConstants.vPadding),
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(AppConstants.radius)),
              child: Text(
                widget.app.name,
                style: TextStyles.mainTextStyle.apply(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
