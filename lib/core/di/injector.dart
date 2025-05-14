import 'package:api_clean_architecture/core/networking/network_service.dart';
import 'package:api_clean_architecture/features/product_listing/data/datasource/listing_datasource.dart';
import 'package:api_clean_architecture/features/product_listing/data/repository_impl/listing_repository_impl.dart';
import 'package:api_clean_architecture/features/product_listing/domain/repository/listing_repository.dart';
import 'package:api_clean_architecture/features/product_listing/domain/usecase/listing_usecase.dart';
import 'package:api_clean_architecture/features/product_listing/presentation/bloc/listing_bloc.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static final injectorInstatnce = GetIt.instance;

  static void initInjector() {
    injectorInstatnce.registerLazySingleton<NetworkService>(
      () => NetworkService(),
    );
    injectorInstatnce.registerLazySingleton<ListingDatasource>(
      () => ListingDataSourceImpl(injectorInstatnce<NetworkService>()),
    );
    injectorInstatnce.registerLazySingleton<ListingRepository>(
      () => ListingRepositoryImpl(injectorInstatnce<ListingDatasource>()),
    );
    injectorInstatnce.registerLazySingleton<ListingUsecase>(
      () => ListingUsecase(injectorInstatnce<ListingRepository>()),
    );
    injectorInstatnce.registerFactory<ListingBloc>(
      () => ListingBloc(injectorInstatnce<ListingUsecase>()),
    );
  }
}
