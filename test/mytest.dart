import 'package:blog_app/features/profile/data/datasources/remote_datasource.dart';

void main() async {
  final ProfileRemoteDataSourceImplementation
  profileRemoteDataSourceImplementation =
      ProfileRemoteDataSourceImplementation();

  var response = await profileRemoteDataSourceImplementation.getAllUser(1);

  for (var element in response) {
    print(element.toJSON());
  }

  print(response);
}
