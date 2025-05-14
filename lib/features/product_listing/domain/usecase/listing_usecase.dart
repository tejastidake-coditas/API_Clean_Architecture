import 'package:api_clean_architecture/core/networking/failure.dart';
import 'package:api_clean_architecture/features/product_listing/domain/entity/listing_entity.dart';
import 'package:api_clean_architecture/features/product_listing/domain/repository/listing_repository.dart';
import 'package:dartz/dartz.dart';

class ListingUsecase {
  final ListingRepository listingRepository;
  ListingUsecase(this.listingRepository);

  Future<Either<Failure, List<ListingEntity>>> getAllProducts() async {
    final result = await listingRepository.getAllProducts();
    return result;
  }
}
