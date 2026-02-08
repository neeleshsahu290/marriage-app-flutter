import 'dart:convert';

class User {
  User({
    required this.matchId,
    required this.status,
    required this.userId,
    required this.fullName,
    required this.location,
    required this.dob,
    required this.gender,
    required this.heightCm,
    required this.religion,
    required this.religiousFaith,
    required this.languagesKnown,
    required this.bio,
    required this.maritalStatus,
    required this.hasChildren,
    required this.familyType,
    required this.parentsStatus,
    required this.educationLevel,
    required this.profession,
    required this.personalityTraits,
    required this.hobbies,
    required this.profilePhotos,
    required this.habits,
    required this.images,
    required this.marriagePriority,
    required this.phone,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.isSentByMe,
    required this.requestType,
    required this.latitude,
    required this.longitude,

    required this.phoneVerified,
    required this.emailVerified,
    required this.isActive,

    required this.showOnlineStatus,
    required this.showEmail,
    required this.showPhone,

    required this.photoVisibility,
  });

  final String? matchId;
  final String? status;
  final String? userId;
  final String? fullName;
  final String? location;

  final DateTime? dob;
  final String? gender;
  final String? heightCm;
  final String? religion;
  final String? religiousFaith;

  final List<String> languagesKnown;

  final String? bio;
  final String? maritalStatus;
  final bool? hasChildren;
  final String? familyType;
  final String? parentsStatus;
  final String? educationLevel;
  final String? profession;

  final List<String> personalityTraits;
  final List<String> hobbies;
  final List<String> profilePhotos;
  final List<String> habits;
  final List<String> images;

  final String? marriagePriority;

  final String? phone;
  final String? email;
  final bool? isSentByMe;
  final String? requestType;

  final double? latitude;
  final double? longitude;

  final bool? phoneVerified;
  final bool? emailVerified;
  final bool? isActive;

  final bool? showOnlineStatus;
  final bool? showEmail;
  final bool? showPhone;

  final String? photoVisibility;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      matchId: json["match_id"],
      status: json["status"],
      userId: json["user_id"],
      fullName: json["full_name"],
      location: json["location"],
      dob: DateTime.tryParse(json["dob"] ?? ""),
      gender: json["gender"],
      heightCm: json["height_cm"].toString(),
      religion: json["religion"],
      religiousFaith: json["religious_faith"],

      languagesKnown: json["languages_known"] == null
          ? []
          : List<String>.from(json["languages_known"].map((x) => x)),

      bio: json["bio"],
      maritalStatus: json["marital_status"],
      hasChildren: json["has_children"],
      familyType: json["family_type"],
      parentsStatus: json["parents_status"],
      educationLevel: json["education_level"],
      profession: json["profession"],

      personalityTraits: json["personality_traits"] == null
          ? []
          : List<String>.from(json["personality_traits"].map((x) => x)),

      hobbies: json["hobbies"] == null
          ? []
          : List<String>.from(json["hobbies"].map((x) => x)),

      profilePhotos: json["profile_photos"] == null
          ? []
          : List<String>.from(json["profile_photos"].map((x) => x)),

      habits: json["habits"] == null
          ? []
          : List<String>.from(json["habits"].map((x) => x)),

      images: json["images"] == null
          ? []
          : List<String>.from(json["images"].map((x) => x)),

      marriagePriority: json["marriage_priority"],

      phone: json["phone"],
      email: json["email"],
      isSentByMe: json["is_sent_by_me"],
      requestType: json["request_type"],
      latitude: json["latitude"] == null
          ? null
          : double.tryParse(json["latitude"].toString()),

      longitude: json["longitude"] == null
          ? null
          : double.tryParse(json["longitude"].toString()),

      phoneVerified: json["phone_verified"],
      emailVerified: json["email_verified"],
      isActive: json["is_active"],

      showOnlineStatus: json["show_online_status"],
      showEmail: json["show_email"],
      showPhone: json["show_phone"],

      photoVisibility: json["photo_visibility"],

      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  factory User.fromDb(Map<String, dynamic> map) {
    return User(
      matchId: map["match_id"],
      status: map["status"],
      userId: map["user_id"],
      fullName: map["full_name"],
      location: map["location"],
      dob: DateTime.tryParse(map["dob"] ?? ""),
      gender: map["gender"],
      heightCm: map["height_cm"],
      religion: map["religion"],
      religiousFaith: map["religious_faith"],

      languagesKnown: map["languages_known"] == null
          ? []
          : List<String>.from(jsonDecode(map["languages_known"])),

      bio: map["bio"],
      maritalStatus: map["marital_status"],
      hasChildren: map["has_children"] == null
          ? null
          : map["has_children"] == 1,
      familyType: map["family_type"],
      parentsStatus: map["parents_status"],
      educationLevel: map["education_level"],
      profession: map["profession"],

      personalityTraits: map["personality_traits"] == null
          ? []
          : List<String>.from(jsonDecode(map["personality_traits"])),

      hobbies: map["hobbies"] == null
          ? []
          : List<String>.from(jsonDecode(map["hobbies"])),

      profilePhotos: map["profile_photos"] == null
          ? []
          : List<String>.from(jsonDecode(map["profile_photos"])),

      habits: map["habits"] == null
          ? []
          : List<String>.from(jsonDecode(map["habits"])),

      images: map["images"] == null
          ? []
          : List<String>.from(jsonDecode(map["images"])),

      marriagePriority: map["marriage_priority"],

      phone: map["phone"],

      email: map["email"],

      isSentByMe: map["is_sent_by_me"] == null
          ? null
          : map["is_sent_by_me"] == 1,
      requestType: map["request_type"],
      latitude: map["latitude"] == null
          ? null
          : double.tryParse(map["latitude"].toString()),

      longitude: map["longitude"] == null
          ? null
          : double.tryParse(map["longitude"].toString()),

      phoneVerified: map["phone_verified"] == null
          ? null
          : map["phone_verified"] == 1,

      emailVerified: map["email_verified"] == null
          ? null
          : map["email_verified"] == 1,

      isActive: map["is_active"] == null ? null : map["is_active"] == 1,

      showOnlineStatus: map["show_online_status"] == null
          ? null
          : map["show_online_status"] == 1,

      showEmail: map["show_email"] == null ? null : map["show_email"] == 1,

      showPhone: map["show_phone"] == null ? null : map["show_phone"] == 1,

      photoVisibility: map["photo_visibility"],

      createdAt: DateTime.tryParse(map["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(map["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "match_id": matchId,
      "status": status,
      "user_id": userId,
      "full_name": fullName,
      "location": location,
      "dob": dob?.toIso8601String(),
      "gender": gender,
      "height_cm": heightCm,
      "religion": religion,
      "religious_faith": religiousFaith,
      "languages_known": languagesKnown,
      "bio": bio,
      "marital_status": maritalStatus,
      "has_children": hasChildren,
      "family_type": familyType,
      "parents_status": parentsStatus,
      "education_level": educationLevel,
      "profession": profession,
      "personality_traits": personalityTraits,
      "hobbies": hobbies,
      "profile_photos": profilePhotos,
      "habits": habits,
      "images": images,
      "marriage_priority": marriagePriority,
      "phone": phone,
      "email": email,
      "is_sent_by_me": isSentByMe,
      "request_type": requestType,
      "latitude": latitude,
      "longitude": longitude,

      "phone_verified": phoneVerified,
      "email_verified": emailVerified,
      "is_active": isActive,

      "show_online_status": showOnlineStatus,
      "show_email": showEmail,
      "show_phone": showPhone,

      "photo_visibility": photoVisibility,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toDb() {
    return {
      "match_id": matchId,
      "status": status,
      "user_id": userId,
      "full_name": fullName,
      "location": location,
      "dob": dob?.toIso8601String(),
      "gender": gender,
      "height_cm": heightCm,
      "religion": religion,
      "religious_faith": religiousFaith,

      "languages_known": jsonEncode(languagesKnown),
      "bio": bio,
      "marital_status": maritalStatus,
      "has_children": hasChildren == null ? null : (hasChildren! ? 1 : 0),
      "family_type": familyType,
      "parents_status": parentsStatus,
      "education_level": educationLevel,
      "profession": profession,

      "personality_traits": jsonEncode(personalityTraits),
      "hobbies": jsonEncode(hobbies),
      "profile_photos": jsonEncode(profilePhotos),
      "habits": jsonEncode(habits),
      "images": jsonEncode(images),

      "marriage_priority": marriagePriority,
      "phone": phone,
      "email": email,
      "is_sent_by_me": isSentByMe == null ? null : (isSentByMe! ? 1 : 0),
      "request_type": requestType,
      "latitude": latitude,
      "longitude": longitude,

      "phone_verified": phoneVerified == null ? null : (phoneVerified! ? 1 : 0),
      "email_verified": emailVerified == null ? null : (emailVerified! ? 1 : 0),
      "is_active": isActive == null ? null : (isActive! ? 1 : 0),

      "show_online_status": showOnlineStatus == null
          ? null
          : (showOnlineStatus! ? 1 : 0),

      "show_email": showEmail == null ? null : (showEmail! ? 1 : 0),
      "show_phone": showPhone == null ? null : (showPhone! ? 1 : 0),

      "photo_visibility": photoVisibility,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "$matchId, $status, $userId, $fullName, $dob, $gender, $heightCm, "
        "$religion, $religiousFaith, $languagesKnown, $bio, $maritalStatus, "
        "$hasChildren, $familyType, $parentsStatus, $educationLevel, "
        "$profession, $personalityTraits, $hobbies, $profilePhotos, "
        "$habits, $images, $marriagePriority, $phone, $email, $isSentByMe, $requestType"
        "$createdAt, $updatedAt";
  }
}
