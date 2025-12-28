import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:home_decor/core/data/dio_client.dart';
import 'package:home_decor/feature/auth/data/datasources/auth_local_datasource.dart';
import 'package:home_decor/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_decor/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:home_decor/feature/auth/domain/repository/auth_repository.dart';
import 'package:home_decor/feature/auth/domain/usecases/auth_usecases.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_decor/feature/home/data/datasource/item_datasource.dart';
import 'package:home_decor/feature/home/data/repository/item_repository_impl.dart';
import 'package:home_decor/feature/home/domain/repository/item_repository.dart';
import 'package:home_decor/feature/home/domain/usecases/item_usecases.dart';
import 'package:home_decor/feature/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.I; // service locator

Future<void> init() async {
  // application layer
  sl.registerFactory(() => HomeBloc(itemUsecases: sl()));
  sl.registerFactory(() => AuthBloc(authUsecases: sl()));

  // domain layer
  sl.registerFactory(() => ItemUsecases(itemRepository: sl()));
  sl.registerFactory(() => AuthUsecases(authRepository: sl()));

  // data layer
  sl.registerFactory<ItemRepository>(
    () => ItemRepositoryImpl(itemDatasource: sl()),
  );
  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authLocalDatasource: sl(),
      authRemoteDatasource: sl(),
    ),
  );

  sl.registerFactory<ItemDatasource>(() => ItemDatasourceImpl(dio: sl()));
  sl.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerFactory<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(flutterSecureStorage: sl()),
  );

  // Dio client
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Expose Dio with baseUrl
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);

  // External / core services
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
}
