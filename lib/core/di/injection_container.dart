// core/di/injection_container.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../network/network_info.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../storage/secure_storage_service.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/menu/data/datasources/category_remote_datasource.dart';
import '../../features/menu/data/repositories/category_repository_impl.dart';
import '../../features/menu/domain/repositories/category_repository.dart';
import '../../features/menu/domain/usecases/get_categories_usecase.dart';
import '../../features/menu/presentation/bloc/category_bloc.dart';
import '../../features/sub_category/data/datasources/sub_category_remote_datasource.dart';
import '../../features/sub_category/data/repositories/sub_category_repository_impl.dart';
import '../../features/sub_category/domain/repositories/sub_category_repository.dart';
import '../../features/sub_category/domain/usecases/get_sub_categories_usecase.dart';
import '../../features/sub_category/presentation/bloc/sub_category_bloc.dart';
import '../../features/child_category/data/datasources/child_category_remote_datasource.dart';
import '../../features/child_category/data/repositories/child_category_repository_impl.dart';
import '../../features/child_category/domain/repositories/child_category_repository.dart';
import '../../features/child_category/domain/usecases/get_child_categories.dart';
import '../../features/child_category/presentation/bloc/child_category_bloc.dart';
import '../../features/posters/data/datasources/poster_remote_datasource.dart';
import '../../features/posters/data/repositories/poster_repository_impl.dart';
import '../../features/posters/domain/repositories/poster_repository.dart';
import '../../features/posters/domain/usecases/get_posters.dart';
import '../../features/posters/presentation/bloc/poster_bloc.dart';
import '../../features/banners/data/datasources/banner_remote_datasource.dart';
import '../../features/banners/data/repositories/banner_repository_impl.dart';
import '../../features/banners/domain/repositories/banner_repository.dart';
import '../../features/banners/domain/usecases/get_banner_details.dart';
import '../../features/banners/presentation/bloc/banner_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));
  dio.interceptors.add(AuthInterceptor(dio, sl()));
  if (kDebugMode) {
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
  }
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => ApiClient(sl()));

  // Feature: Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl(), sl()));
  sl.registerLazySingleton(() => SendOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerFactory(() => AuthBloc(
        sendOtpUseCase: sl(),
        verifyOtpUseCase: sl(),
      ));

  // Feature: Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerFactory(() => ProfileBloc(getProfileUseCase: sl()));

  // Feature: Category
  sl.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerFactory(() => CategoryBloc(getCategoriesUseCase: sl()));

  // Feature: Sub-Category
  sl.registerLazySingleton<SubCategoryRemoteDataSource>(() => SubCategoryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<SubCategoryRepository>(
      () => SubCategoryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => GetSubCategoriesUseCase(sl()));
  sl.registerFactory(() => SubCategoryBloc(getSubCategoriesUseCase: sl()));

  // Feature: Child-Category
  sl.registerLazySingleton<ChildCategoryRemoteDataSource>(() => ChildCategoryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ChildCategoryRepository>(
      () => ChildCategoryRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetChildCategories(sl()));
  sl.registerFactory(() => ChildCategoryBloc(getChildCategories: sl()));

  // Feature: Posters
  sl.registerLazySingleton<PosterRemoteDataSource>(() => PosterRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PosterRepository>(
      () => PosterRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetPosters(sl()));
  sl.registerFactory(() => PosterBloc(getPosters: sl()));

  // Feature: Banners
  sl.registerLazySingleton<BannerRemoteDataSource>(() => BannerRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<BannerRepository>(
      () => BannerRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetBannerDetails(sl()));
  sl.registerFactory(() => BannerBloc(getBannerDetails: sl()));

  // Har naya feature yaha apne datasource/repo/usecase/bloc register karega
}
