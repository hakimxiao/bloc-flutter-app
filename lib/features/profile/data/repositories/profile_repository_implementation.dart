import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/profile/data/datasources/local_datasource.dart';
import 'package:blog_app/features/profile/data/datasources/remote_datasource.dart';
import 'package:blog_app/features/profile/data/models/profile_model.dart';
import 'package:blog_app/features/profile/domain/entities/profile.dart';
import 'package:blog_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';

class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSourcel;
  final HiveInterface hive;

  ProfileRepositoryImplementation({
    required this.profileRemoteDataSource,
    required this.profileLocalDataSourcel,
    required this.hive,
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUsers(int page) async {
    try {
      // Check internet
      final List<ConnectivityResult> connectivityResult = await (Connectivity()
          .checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network
        // Ngambil dari local datasource
        List<ProfileModel> hasil = await profileLocalDataSourcel.getAllUser(
          page,
        );
        return Right(hasil);
      } else {
        // Available network
        // Ngambil dari remote datasource
        List<ProfileModel> hasil = await profileRemoteDataSource.getAllUser(
          page,
        );
        // Put last data profile ke box local
        var box = hive.box("profile_box");
        box.put("getAllUser", hasil);

        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser(int id) async {
    try {
      // Check internet
      final List<ConnectivityResult> connectivityResult = await (Connectivity()
          .checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network
        // Ngambil dari local datasource
        ProfileModel hasil = await profileLocalDataSourcel.getUser(id);
        return Right(hasil);
      } else {
        // Available network
        // Ngambil dari remote datasource
        ProfileModel hasil = await profileRemoteDataSource.getUser(id);
        // Put last data profile ke box local
        var box = hive.box("profile_box");
        box.put("getUser", hasil);

        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
