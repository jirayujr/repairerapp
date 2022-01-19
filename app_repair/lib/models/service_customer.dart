import 'dart:convert';

class ServiceCustomer {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String select_time_date;
  final String type_technician;
  final String detail;
  final String images;
  final String address;
  final String lat;
  final String lng;
  final String id_customer;
  final String time;
  final String date;
  ServiceCustomer({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.select_time_date,
    required this.type_technician,
    required this.detail,
    required this.images,
    required this.address,
    required this.lat,
    required this.lng,
    required this.id_customer,
    required this.time,
    required this.date,
  });

  ServiceCustomer copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? phone,
    String? select_time_date,
    String? type_technician,
    String? detail,
    String? images,
    String? address,
    String? lat,
    String? lng,
    String? id_customer,
    String? time,
    String? date,
  }) {
    return ServiceCustomer(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      select_time_date: select_time_date ?? this.select_time_date,
      type_technician: type_technician ?? this.type_technician,
      detail: detail ?? this.detail,
      images: images ?? this.images,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      id_customer: id_customer ?? this.id_customer,
      time: time ?? this.time,
      date:  date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'select_time_date': select_time_date,
      'type_technician': type_technician,
      'detail': detail,
      'images': images,
      'address': address,
      'lat': lat,
      'lng': lng,
      'id_customer': id_customer,
      'time': time,
      'date': date,
    };
  }

  factory ServiceCustomer.fromMap(Map<String, dynamic> map) {
    return ServiceCustomer(
      id: map['id'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      phone: map['phone'] ?? '',
      select_time_date: map['select_time_date'] ?? '',
      type_technician: map['type_technician'] ?? '',
      detail: map['detail'] ?? '',
      images: map['images'] ?? '',
      address: map['address'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
      id_customer: map['id_customer'] ?? '',
      time: map['time']?? '',
      date: map['date']?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceCustomer.fromJson(String source) => ServiceCustomer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceCustomer(id: $id, firstname: $firstname, lastname: $lastname, phone: $phone, select_time_date: $select_time_date, type_technician: $type_technician, detail: $detail, images: $images, address: $address, lat: $lat, lng: $lng, id_customer: $id_customer,time:$time,date$date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ServiceCustomer &&
      other.id == id &&
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.phone == phone &&
      other.select_time_date == select_time_date &&
      other.type_technician == type_technician &&
      other.detail == detail &&
      other.images == images &&
      other.address == address &&
      other.lat == lat &&
      other.lng == lng &&
      other.id_customer == id_customer&&
      other.time == time &&
      other.time == date
      ;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      phone.hashCode ^
      select_time_date.hashCode ^
      type_technician.hashCode ^
      detail.hashCode ^
      images.hashCode ^
      address.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      id_customer.hashCode^
      time.hashCode ^
      date.hashCode 
      ;
  }
}
