import 'package:api_clean_architecture/core/networking/network_service.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static final injectorInstatnce = GetIt.instance;

  static void initInjector() {
    injectorInstatnce.registerLazySingleton<NetworkService>(
      () => NetworkService(),
    );
    injectorInstatnce.registerLazySingleton<ListingDatasource>(
      () => ListingDatasourceImpl(injectorInstatnce<NetworkService>()),
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
