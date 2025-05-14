import 'package:api_clean_architecture/core/networking/failure.dart';
import 'package:api_clean_architecture/features/product_listing/data/datasource/listing_datasource.dart';
import 'package:api_clean_architecture/features/product_listing/domain/entity/listing_entity.dart';
import 'package:api_clean_architecture/features/product_listing/domain/repository/listing_repository.dart';
import 'package:dartz/dartz.dart';

class ListingRepositoryImpl implements ListingRepository {
  final ListingDatasource listingDatasource;
  ListingRepositoryImpl(this.listingDatasource);

  @override
  Future<Either<Failure, List<ListingEntity>>> getAllProducts() async {
    final result = await listingDatasource.getAllProducts();
    return result;
  }
}
