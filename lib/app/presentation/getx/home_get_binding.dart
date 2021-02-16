import 'package:get/get.dart';

import '../../../di/injector.dart';
import '../../core/utils/input_converter.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';
import 'home_get_controller.dart';

///The Binding of HomeGet View
class HomeGetBinding implements Bindings {
  const HomeGetBinding();
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeGetController(
        concrete: Injector.resolve<GetConcreteNumberTrivia>(),
        random: Injector.resolve<GetRandomNumberTrivia>(),
        inputConverter: Injector.resolve<InputConverter>(),
      ),
    );
  }
}
