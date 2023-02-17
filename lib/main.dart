import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_os_ui/components/task_bar.dart';
import 'package:mac_os_ui/core/startup.dart';
import 'package:mac_os_ui/gen/assets.gen.dart';
import 'package:provider/provider.dart';

import './components/app_bar.dart';
import 'data/models/task.dart';
import 'providers/app_state.dart';
import 'widgets/task_widget.dart';

Future<void> main() async {
  await Startup.run();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MacOS UI',
        theme: ThemeData(
          textTheme: GoogleFonts.dmSansTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<AnimationController> taskAnimationControllers = [];

  List<SequenceAnimation> animations = [];

  late Animation<double> translateAnimation;

  @override
  void initState() {
    super.initState();

    initializeAnimations();
  }

  initializeAnimations() {
    for (var i = 0; i < tasks.length; i++) {
      taskAnimationControllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        ),
      );

      SequenceAnimation sequenceAnimation = SequenceAnimationBuilder()
          .addAnimatable(
              from: const Duration(milliseconds: 0),
              to: const Duration(milliseconds: 300),
              animatable: Tween<double>(
                begin: 0,
                end: 1.0,
              ),
              tag: 'opacity')
          .addAnimatable(
              from: const Duration(milliseconds: 0),
              to: const Duration(milliseconds: 300),
              animatable: Tween<double>(
                begin: .02,
                end: 1.0,
              ),
              tag: 'scale')
          .addAnimatable(
              from: const Duration(milliseconds: 0),
              to: const Duration(milliseconds: 300),
              animatable: Tween<double>(
                begin: /*WidgetFinder.of(
                        Provider.of<AppState>(context, listen: false).keys[i])
                    .topLeft
                    .dy,*/
                    -50 * (i + 2),
                end: 0.0,
              ),
              tag: 'translate')
          .animate(taskAnimationControllers[i]);
      animations.add(sequenceAnimation);

      taskAnimationControllers[i].addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.zero, child: SizedBox.shrink()),
        body: Consumer<AppState>(
          builder: (context, appState, _) => Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    image: const $AssetsImagesGen()
                        .wp7542064MacosBigSurHdWallpapers
                        .provider(),
                  ),
                ),
              ),
              const Positioned(
                left: 60,
                right: 60,
                bottom: 12,
                child: MyAppBar(),
              ),
              buildCurrentTaskWidget(
                appState.task,
              ),
              if (appState.previousTask != null)
                buildCurrentTaskWidget(appState.previousTask!),
              Positioned(
                top: 60,
                bottom: 60,
                left: 0,
                child: TaskBar(onTaskSelected: (index) {
                  if (appState.previousTask != null) {
                    taskAnimationControllers[
                            tasks.indexOf(appState.previousTask!)]
                        .reverse();
                  }
                  taskAnimationControllers[index].forward();
                }),
              ),
            ],
          ),
        ),
      );

  buildCurrentTaskWidget(Task pTask) {
    Animation<double> scaleAnimation =
        animations[tasks.indexOf(pTask)]['scale'] as Animation<double>;

    Animation<double> translateAnimation =
        animations[tasks.indexOf(pTask)]['translate'] as Animation<double>;

    Animation<double> opacityAnimation =
        animations[tasks.indexOf(pTask)]['opacity'] as Animation<double>;

    return Positioned.fill(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Transform(
        alignment: Alignment.centerLeft,
        transform: Matrix4.identity()
          ..setEntry(3, 2, .002)
          ..translate(
            (translateAnimation.value),
            1.2,
            -1 * (translateAnimation.value) * 3,
          ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: opacityAnimation.value,
          child: ScaleTransition(
            alignment: Alignment.centerLeft,
            scale: scaleAnimation,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .65,
                  width: MediaQuery.of(context).size.width * .65,
                  child: TaskWidget(
                    task: pTask,
                    canZoom: false,
                    showIcon: false,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
