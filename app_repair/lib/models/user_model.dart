import 'dart:convert';

class UserModel {
  final String id;
  final String firstname;
  final String lastname;
  final String type;
  final String address;
  final String phone;
  final String user;
  final String password;
  final String avatar;
  final String lat;
  final String lng;
  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.type,
    required this.address,
    required this.phone,
    required this.user,
    required this.password,
    required this.avatar,
    required this.lat,
    required this.lng,
  });

  UserModel copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? type,
    String? address,
    String? phone,
    String? user,
    String? password,
    String? avatar,
    String? lat,
    String? lng,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      type: type ?? this.type,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      user: user ?? this.user,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'type': type,
      'address': address,
      'phone': phone,
      'user': user,
      'password': password,
      'avatar': avatar,
      'lat': lat,
      'lng': lng,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      type: map['type'],
      address: map['address'],
      phone: map['phone'],
      user: map['user'],
      password: map['password'],
      avatar: map['avatar'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firstname: $firstname,lastname: $lastname, type: $type, address: $address, phone: $phone, user: $user, password: $password, avatar: $avatar, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.type == type &&
        other.address == address &&
        other.phone == phone &&
        other.user == user &&
        other.password == password &&
        other.avatar == avatar &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        type.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        user.hashCode ^
        password.hashCode ^
        avatar.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }
}
