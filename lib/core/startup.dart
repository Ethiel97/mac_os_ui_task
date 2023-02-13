import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class Startup {
  static run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    // Use it only after calling `hiddenWindowAtLaunch`
    windowManager.waitUntilReadyToShow().then((_) async {
      // Hide window title bar
      // await windowManager.setTitleBarStyle(TitleBarStyle.normal);

      await windowManager.setMinimumSize(const Size(1000, 800));
      await windowManager.setTitle("MacOS UI");
      await windowManager.center();
      await windowManager.show();
      // await windowManager.setSkipTaskbar(false);
    });
  }
}
