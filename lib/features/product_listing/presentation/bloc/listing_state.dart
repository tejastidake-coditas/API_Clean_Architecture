import 'package:api_clean_architecture/features/product_listing/domain/entity/listing_entity.dart';
import 'package:equatable/equatable.dart';

sealed class ListingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends ListingState {}

class LoadingState extends ListingState {}

class ErrorState extends ListingState {
  final String message;
  ErrorState(this.message);
}

class ProductListingState extends ListingState {
  final List<ListingEntity> products;
  ProductListingState(this.products);
}
