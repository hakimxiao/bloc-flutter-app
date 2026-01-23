import 'dart:convert';

import 'package:blog_app/core/error/exceptioin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:blog_app/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDataSourceImplementation extends ProfileRemoteDataSource {
  static const _baseUrl = 'https://reqres.in/api';

  Map<String, String> get _headers => {
    'x-api-key': dotenv.env['REQRES_API_KEY']!,
    'Accept': 'application/json',
  };

  final http.Client client;

  ProfileRemoteDataSourceImplementation({required this.client});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    final uri = Uri.parse('$_baseUrl/users?page=$page');

    final response = await client.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List data = body['data'];

      return ProfileModel.fromJSONList(data);
    } else if (response.statusCode == 404) {
      throw EmptyException(message: 'Data not found error 404');
    } else {
      throw GeneralException(message: 'Cannot get data');
    }
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    final uri = Uri.parse('$_baseUrl/users/$id');

    final response = await client.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return ProfileModel.fromJSON(body['data']);
    } else if (response.statusCode == 404) {
      throw EmptyException(message: 'Data not found error 404');
    } else {
      throw GeneralException(message: 'Cannot get data');
    }
  }
}
