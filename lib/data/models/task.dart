import 'package:mac_os_ui/gen/assets.gen.dart';

class Task {
  final String image;

  final String icon;

  const Task({
    required this.image,
    required this.icon,
  });

  @override
  String toString() {
    return 'Task{image: $image, icon: $icon}';
  }
}

List<Task> tasks = [
  Task(
    image: const $AssetsImagesGen().task1.path,
    icon: const $AssetsImagesGen().firefoxAltMacosBigsurIcon190171.path,
  ),
  Task(
    image: const $AssetsImagesGen().task2.path,
    icon: const $AssetsImagesGen().intellijWebstormMacosBigsurIcon190053.path,
  ),
  Task(
    image: const $AssetsImagesGen().task3.path,
    icon: const $AssetsImagesGen().telegramMacosBigsurIcon189662.path,
  ),
  Task(
    image: const $AssetsImagesGen().task4.path,
    icon: const $AssetsImagesGen().discordMacosBigsurIcon190238.path,
  )
];
