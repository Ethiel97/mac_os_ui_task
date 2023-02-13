import 'package:mac_os_ui/gen/assets.gen.dart';

class App {
  final String name;

  final String icon;

  const App({
    required this.name,
    required this.icon,
  });
}

List<App> apps = [
  App(
    name: 'Finder',
    icon: const $AssetsImagesGen().finderMacosBigsurIcon190173.path,
  ),
  App(
    name: 'Firefox',
    icon: const $AssetsImagesGen().firefoxAltMacosBigsurIcon190171.path,
  ),
  App(
    name: 'Telegram',
    icon: const $AssetsImagesGen().telegramMacosBigsurIcon189662.path,
  ),
  App(
    name: 'Photoshop',
    icon: const $AssetsImagesGen().adobePhotoshopMacosBigsurIcon190436.path,
  ),
  App(
    name: 'Discord',
    icon: const $AssetsImagesGen().discordMacosBigsurIcon190238.path,
  ),
  App(
    name: 'Mail',
    icon: const $AssetsImagesGen().mailMacosBigsurIcon190003.path,
  ),
  App(
    name: 'Spotify',
    icon: const $AssetsImagesGen().spotifyAltMacosBigsurIcon189704.path,
  ),
  App(
      name: 'Youtube',
      icon: const $AssetsImagesGen().youtubeMacosBigsurIcon189528.path),
  App(
      name: 'Pycharm',
      icon: const $AssetsImagesGen().intellijPycharmMacosBigsurIcon190055.path),
  App(
    name: 'WebStorm',
    icon: const $AssetsImagesGen().intellijWebstormMacosBigsurIcon190053.path,
  ),
  App(
    name: 'Vlc',
    icon: const $AssetsImagesGen().vlcMacosBigsurIcon189584.path,
  ),
  App(
    name: 'Android Studio',
    icon: const $AssetsImagesGen().androidStudioAltMacosBigsurIcon190395.path,
  ),
  App(
    name: 'VsCode',
    icon: const $AssetsImagesGen()
        .microsoftVisualStudioCodeAltMacosBigsurIcon189955
        .path,
  ),
];
