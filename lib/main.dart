import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_os_ui/components/task_bar.dart';
import 'package:mac_os_ui/core/startup.dart';
import 'package:mac_os_ui/gen/assets.gen.dart';

import './components/app_bar.dart';

Future<void> main() async {
  await Startup.run();
  runApp(const MyApp());
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.zero, child: SizedBox.shrink()),
        body: Stack(
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
              top: 60,
              bottom: 60,
              left: 0,
              child: TaskBar(),
            ),
            const Positioned(
              left: 60,
              right: 60,
              bottom: 12,
              child: MyAppBar(),
            ),
          ],
        ),
      );
}
