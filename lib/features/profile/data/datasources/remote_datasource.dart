import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:blog_app/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDataSourceImplementation extends ProfileRemoteDataSource {
  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    Uri uri = Uri.parse('https://reqres.in/api/users?page=$page');

    var response = await http.get(uri);

    Map<String, dynamic> dataBody = jsonDecode(response.body);
    List<dynamic> data = dataBody["data"];
    return ProfileModel.fromJSONList(data);
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    Uri uri = Uri.parse('https://reqres.in/api/users/$id');
    var response = await http.get(uri);

    Map<String, dynamic> dataBody = jsonDecode(response.body);
    Map<String, dynamic> data = dataBody["data"];

    return ProfileModel.fromJSON(data);
  }
}
