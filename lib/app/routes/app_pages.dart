import 'package:get/get.dart';

import '../presentation/getx/home_get.dart';
import '../presentation/getx/home_get_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeGet(),
      binding: const HomeGetBinding(),
    ),
  ];
}
