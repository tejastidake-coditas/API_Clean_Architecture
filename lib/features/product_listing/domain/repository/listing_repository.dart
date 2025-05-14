import 'package:api_clean_architecture/core/networking/failure.dart';
import 'package:api_clean_architecture/features/product_listing/domain/entity/listing_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class ListingRepository {
  Future<Either<Failure, List<ListingEntity>>> getAllProducts();
}
