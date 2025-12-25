import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:home_decor/core/data/dio_client.dart';
import 'package:home_decor/feature/home/data/datasource/item_datasource.dart';
import 'package:home_decor/feature/home/data/repository/item_repository_impl.dart';
import 'package:home_decor/feature/home/domain/repository/item_repository.dart';
import 'package:home_decor/feature/home/domain/usecases/item_usecases.dart';
import 'package:home_decor/feature/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.I; // service locator

Future<void> init() async {
  // application layer
  sl.registerFactory(() => HomeBloc(itemUsecases: sl()));

  // domain layer
  sl.registerFactory(() => ItemUsecases(itemRepository: sl()));

  // data layer
  sl.registerFactory<ItemRepository>(
    () => ItemRepositoryImpl(itemDatasource: sl()),
  );

  sl.registerFactory<ItemDatasource>(() => ItemDatasourceImpl(dio: sl()));

  // Dio client
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Expose Dio with baseUrl
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);
}
