// USECASE

// INI MERUPAKAN FILE UNTUK USE CASE GET ALL USER :
// USECASE ADALAH FILE YANG BERISI LOGIC DARI DOMAIN LAYER

import 'package:blog_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetAllUsers {
  final ProfileRepository profileRepository;

  const GetAllUsers(this.profileRepository);

  Future<Either<Failure, List<Profile>>> execute(int page) async {
    return await profileRepository.getAllUsers(page);
  }
}
