import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/core/network/network_info.dart';
import '../app/core/utils/input_converter.dart';
import '../app/data/api/dio_api.dart';
import '../app/data/datasources/local/i_number_trivia_local_data_source.dart';
import '../app/data/datasources/remote/i_number_trivia_remote_data_source.dart';
import '../app/data/repositories/number_trivia_repository_impl.dart';
import '../app/domain/repositories/i_number_trivia_repository.dart';
import '../app/domain/usecases/get_concrete_number_trivia.dart';
import '../app/domain/usecases/get_random_number_trivia.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
    _$Injector()._configure();
  }

  static final resolve = container.resolve;

  void _configure() {
    _configureCore();
    _configureTriviaFeatureModule();
  }

//* Core module
  @Register.singleton(DataConnectionChecker)
  @Register.singleton(INetworkInfo, from: NetworkInfoImpl)
  @Register.singleton(InputConverter)
  void _configureCore();

  //* Trivia Feature module
  void _configureTriviaFeatureModule() {
    _configureTriviaFeatureModuleInstances();
    _configureTriviaFeatureModuleFactories();
  }

  //* Trivia Feature module instances
  void _configureTriviaFeatureModuleInstances() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    container.registerSingleton((container) => sharedPreferences);
    //* Chopper instantiation
    // container.registerSingleton((container) => RestClient.create());
    //! Dio instantiation
    container.registerInstance(DioApi(Dio(
      BaseOptions(),
    )));
  }

  //* Trivia Feature module factories
  @Register.factory(INumberTriviaRemoteDataSource,
      from: NumberTriviaRemoteDataSourceImpl)
  @Register.factory(INumberTriviaLocalDataSource,
      from: NumberTriviaLocalDataSourceImpl)
  @Register.factory(GetConcreteNumberTrivia)
  @Register.factory(GetRandomNumberTrivia)
  @Register.factory(INumberTriviaRepository, from: NumberTriviaRepositoryImpl)
  void _configureTriviaFeatureModuleFactories();
}
