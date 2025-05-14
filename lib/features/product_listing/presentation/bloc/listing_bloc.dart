import 'package:api_clean_architecture/features/product_listing/domain/usecase/listing_usecase.dart';
import 'package:api_clean_architecture/features/product_listing/presentation/bloc/listing_event.dart';
import 'package:api_clean_architecture/features/product_listing/presentation/bloc/listing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final ListingUsecase listingUsecase;
  ListingBloc(this.listingUsecase) : super(InitialState()) {
    on<GetAllProductsEvent>(_getAllProducts);
  }
  Future<void> _getAllProducts(
    GetAllProductsEvent event,
    Emitter<ListingState> emit,
  ) async {
    final result = await listingUsecase.getAllProducts();
    return result.fold(
      (failure) {
        emit(ErrorState(failure.toString()));
      },
      (products) {
        emit(LoadingState());
        emit(ProductListingState(products));
      },
    );
  }
}
