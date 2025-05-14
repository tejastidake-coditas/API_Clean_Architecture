import 'package:api_clean_architecture/core/networking/failure.dart';
import 'package:api_clean_architecture/core/networking/network_constants.dart';
import 'package:api_clean_architecture/core/utils/enums/method_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/web.dart';

class NetworkService {
  late final Dio _dio;
  late Logger _logger;

  NetworkService() {
    final header = {'Content-Type': NetworkConstants.headerContentType};
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      headers: header,
      connectTimeout: NetworkConstants.connectTimeout,
      receiveTimeout: NetworkConstants.recieveTimeout,
    );

    _dio = Dio(baseOptions);
    _logger = Logger();

    _initInterceptors();
  }

  void _initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: onRequest,
        onResponse: onResponse,
        onError: onError,
      ),
    );
  }

  dynamic onRequest(RequestOptions requestOptions, handler) {
    _logger.i('${requestOptions.data}');
    return handler.next(requestOptions);
  }

  dynamic onResponse(Response response, handler) {
    _logger.i('${response.data}');
    return handler.next(response);
  }

  dynamic onError(DioException error, handler) {
    _logger.e('$error');
    return handler.next(error);
  }

  Future<Either<Failure, Response<dynamic>>> request(
    String endPoint,
    MethodEnum method,
  ) async {
    Response response;
    try {
      switch (method) {
        case MethodEnum.get:
          response = await _dio.get(endPoint);
      }
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(response);
      } else if (response.statusCode! >= 300 && response.statusCode! < 400) {
        return Left(RedirectionalError());
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        return Left(ClientError());
      } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
        return Left(ServerError());
      } else {
        return Left(CustomError('Something Went Wrong'));
      }
    } on DioException catch (e) {
      return Left(CustomError(e.toString()));
    }
  }
}
