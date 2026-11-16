import 'package:dartz/dartz.dart';
import '../../../../../core/errors/api_error_handler.dart';
import '../../../../../core/errors/failures.dart';
import '../datasourece/admin_trips_remote_data_source.dart';
import '../models/paginated_trips_model.dart';

class AdminTripsRepository {
  final AdminTripsRemoteDataSource _remoteDataSource;

  AdminTripsRepository({required AdminTripsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<Either<Failure, PaginatedTripsModel>> getTrips({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      final response = await _remoteDataSource.getTrips(
        page: page,
        limit: limit,
        status: status,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
