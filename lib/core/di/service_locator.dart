import 'package:get_it/get_it.dart';
import 'package:rahala/features/user/auth/data/datasource/auth_remote_data_source.dart';
import 'package:rahala/features/user/auth/data/repositories/auth_repository.dart';
import 'package:rahala/features/user/auth/presentation/cubit/auth_state_cubit.dart';

import '../../features/admin/dashboard/data/datasourece/admin_dashboard_remote_data_source.dart';
import '../../features/admin/dashboard/data/repositories/admin_dashboard_stats_repository.dart';
import '../../features/admin/dashboard/presentation/cubit/admin_cubit.dart';
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
}
