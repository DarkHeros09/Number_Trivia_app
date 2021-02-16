//import dio with prefix to avoid the conflict with retrofit package when calling the headers
import 'package:dio/dio.dart' as client;
import 'package:retrofit/retrofit.dart';

import '../models/number_trivia_model.dart';

part 'dio_api.g.dart';

@RestApi(baseUrl: 'http://numbersapi.com/')
abstract class DioApi {
  factory DioApi(client.Dio dio, {String baseUrl}) = _DioApi;

  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  @GET('/{url}')
  Future<NumberTriviaModel> getTriviaFromUrl(@Path() String url);
}
