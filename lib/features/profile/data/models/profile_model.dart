import 'package:blog_app/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  final String firstName;
  final String lastName;
  final String avatar;

  const ProfileModel({
    required super.id,
    required super.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  }) : super(fullName: "$firstName $lastName", profileImageUrl: avatar);

  // MAP -> ProfileModel
  factory ProfileModel.fromJSON(Map<String, dynamic> data) {
    return ProfileModel(
      id: data["id"],
      email: data["email"],
      firstName: data["first_name"],
      lastName: data["last_name"],
      avatar: data["avatar"],
    );
  }

  // ProfileModel -> MAP
  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
    };
  }

  // List<Map> -> List<ProfileModel>
  static List<ProfileModel> fromJSONList(List data) {
    if (data.isEmpty) return [];

    // OPSI 1: For loop
    // List<ProfileModel> allData = [];
    // for (var i = 0; i < data.length; i++) {
    //   Map<String, dynamic> singleDataProfile = data[i];

    //   allData.add(ProfileModel.fromJSON(singleDataProfile));
    // }

    // return allData;

    // OPSI 2: Map
    return data.map((e) => ProfileModel.fromJSON(e)).toList();
  }
}


// JIKA NAMA OVERRIDE NYA SAMA DENGAN SUPER PADA PARRENT NYA MAKA 
// PADA SAAT OVERRIDE CLASS JANGAN GUNAKAN this. TAPI GUNAKAN super. SEHINGGA KITA TIDAK
// PERLU MENDEFINISIKAN DI AKHIR OVERRIDE LAGI KECUALI YANG BERBEDA

// DI MODEL WAJIB ADA FROM JSON DAN TO JSON