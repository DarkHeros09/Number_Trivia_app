// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureCore() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => DataConnectionChecker());
    container.registerSingleton<INetworkInfo>(
        (c) => NetworkInfoImpl(connectionChecker: c<DataConnectionChecker>()));
    container.registerSingleton((c) => InputConverter());
  }

  @override
  void _configureTriviaFeatureModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory<INumberTriviaRemoteDataSource>(
        (c) => NumberTriviaRemoteDataSourceImpl(dioApi: c<DioApi>()));
    container.registerFactory<INumberTriviaLocalDataSource>((c) =>
        NumberTriviaLocalDataSourceImpl(
            sharedPrefrences: c<SharedPreferences>()));
    container.registerFactory((c) =>
        GetConcreteNumberTrivia(repository: c<INumberTriviaRepository>()));
    container.registerFactory(
        (c) => GetRandomNumberTrivia(repository: c<INumberTriviaRepository>()));
    container.registerFactory<INumberTriviaRepository>((c) =>
        NumberTriviaRepositoryImpl(
            networkInfo: c<INetworkInfo>(),
            remoteDataSource: c<INumberTriviaRemoteDataSource>(),
            localDataSource: c<INumberTriviaLocalDataSource>()));
  }
}
