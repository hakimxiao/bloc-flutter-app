// ignore_for_file: public_member_api_docs, sort_constructors_first
// INI ENTITAS PROFILE

// * JELASKAN APA ITU EQUATABLE DAN KENAPA DIPAKAI DISINI

// SHORT KEY :
// + MISSING OVERRIDE EQUATABLE PAKAI GENERATE EQUATABLE
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final int id;
  final String email;
  final String fullName;
  final String profileImageUrl;

  const Profile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.profileImageUrl,
  });

  @override
  List<Object> get props => [id, email, fullName, profileImageUrl];
}
