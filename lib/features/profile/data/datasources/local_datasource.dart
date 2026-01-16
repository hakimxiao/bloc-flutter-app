import 'package:hive/hive.dart';

import 'package:blog_app/features/profile/data/models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileLocalDataSourceImplementation extends ProfileLocalDataSource {
  final HiveInterface hive;

  ProfileLocalDataSourceImplementation({required this.hive});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    var box = hive.box('profileBox');
    return box.get('allUser');
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    var box = hive.box('profileBox');
    return box.get('allUser');
  }
}
