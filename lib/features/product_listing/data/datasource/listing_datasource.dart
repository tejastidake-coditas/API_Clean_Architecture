import 'package:api_clean_architecture/core/networking/failure.dart';
import 'package:api_clean_architecture/core/networking/network_constants.dart';
import 'package:api_clean_architecture/core/networking/network_service.dart';
import 'package:api_clean_architecture/core/utils/enums/method_enum.dart';
import 'package:api_clean_architecture/features/product_listing/data/model/listing_model.dart';
import 'package:api_clean_architecture/features/product_listing/domain/entity/listing_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ListingDatasource {
  Future<Either<Failure, List<ListingEntity>>> getAllProducts();
}

class ListingDataSourceImpl implements ListingDatasource {
  final NetworkService networkService;
  ListingDataSourceImpl(this.networkService);

  @override
  Future<Either<Failure, List<ListingEntity>>> getAllProducts() async {
    try {
      final result = await networkService.request(
        NetworkConstants.productEndpoint,
        MethodEnum.get,
      );

      return result.fold((failure) => Left(failure), (response) {
        if (response.data is Map<String, dynamic>) {
          final List data = response.data['products'] ?? [];
          final products =
              data.map((product) => ListingModel.fromJson(product)).toList();
          return Right(products);
        } else {
          return Left(CustomError('Unsupported Format'));
        }
      });
    } on DioException catch (e) {
      return Left(CustomError(e.toString()));
    }
  }
}
