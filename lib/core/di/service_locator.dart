import 'package:get_it/get_it.dart';
import 'package:rahala/features/admin/trips/data/datasourece/admin_trips_remote_data_source.dart';
import 'package:rahala/features/user/auth/data/datasource/auth_remote_data_source.dart';
import 'package:rahala/features/user/auth/data/repositories/auth_repository.dart';
import 'package:rahala/features/user/auth/presentation/cubit/auth_state_cubit.dart';
import '../../features/admin/dashboard/data/datasourece/admin_dashboard_remote_data_source.dart';
import '../../features/admin/dashboard/data/repositories/admin_dashboard_stats_repository.dart';
import '../../features/admin/dashboard/presentation/cubit/admin_cubit.dart';
import '../../features/admin/manage_trips/data/datasource/admin_manage_trips_data_source.dart';
import '../../features/admin/manage_trips/data/repositories/admin_manage_trips_repository.dart';
import '../../features/admin/manage_trips/presentation/cubit/admin_manage_trips_cubit.dart';
import '../../features/admin/trips/data/repositories/admin_trips_repository.dart';
import '../../features/admin/trips/presentation/cubit/admin_trips_cubit.dart';
import '../../features/categories/data/datasources/categories_remote_data_source.dart';
import '../../features/categories/data/repositories/categories_repository.dart';
import '../../features/categories/presentation/cubits/categories_cubit.dart';
import '../network/dio_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> initServiceLocator() async {
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(authRemoteDataSource: getIt()),
  );

  getIt.registerFactory<AuthStateCubit>(
    () => AuthStateCubit(authRepository: getIt()),
  );

  /// Admin
  getIt.registerLazySingleton<AdminDashboardRemoteDataSource>(
    () => AdminDashboardRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AdminDashboardStatsRepository>(
    () => AdminDashboardStatsRepository(remoteDataSource: getIt()),
  );

  getIt.registerFactory<AdminCubit>(
    () => AdminCubit(adminDashboardStatsRepository: getIt()),
  );

  /// Admin Trips
  getIt.registerLazySingleton<AdminTripsRemoteDataSource>(
    () => AdminTripsRemoteDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerLazySingleton<AdminTripsRepository>(
    () => AdminTripsRepository(remoteDataSource: getIt()),
  );

  getIt.registerFactory<AdminTripsCubit>(() => AdminTripsCubit(getIt()));

  /// Admin Manage Trips
  getIt.registerLazySingleton<AdminManageTripsDataSource>(
    () => AdminManageTripsDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AdminManageTripsRepository>(
    () => AdminManageTripsRepository(getIt()),
  );

  getIt.registerFactory<AdminManageTripsCubit>(
    () => AdminManageTripsCubit(getIt()),
  );

  /// Categories
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(
        () => CategoriesRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<CategoriesRepository>(
        () => CategoriesRepository(getIt()),
  );

  getIt.registerFactory<CategoriesCubit>(
        () => CategoriesCubit(getIt()),
  );
}
