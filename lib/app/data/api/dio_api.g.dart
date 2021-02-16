// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DioApi implements DioApi {
  _DioApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://numbersapi.com/';
  }

  final client.Dio _dio;

  String baseUrl;

  @override
  Future<NumberTriviaModel> getTriviaFromUrl(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/$url',
        queryParameters: queryParameters,
        options: client.RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Content-Type': 'application/json'},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = NumberTriviaModel.fromJson(_result.data);
    return value;
  }
}
