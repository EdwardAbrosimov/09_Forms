import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class HotelInfo {
  final String uuid, name, poster;
  final Address address;
  final double price, rating;
  final Services services;
  final List<String> photos;

  HotelInfo(
      {required this.uuid,
      required this.name,
      required this.poster,
      required this.address,
      required this.price,
      required this.rating,
      required this.services,
      required this.photos});

  factory HotelInfo.fromJson(Map<String, dynamic> json) =>
      _$HotelInfoFromJson(json);
  Map<String, dynamic> toJson() => _$HotelInfoToJson(this);
}

@JsonSerializable()
class Preview {
  final String uuid, name, poster;
  Preview({required this.uuid, required this.name, required this.poster});

  factory Preview.fromJson(Map<String, dynamic> json) =>
      _$PreviewFromJson(json);
  Map<String, dynamic> toJson() => _$PreviewToJson(this);
}

@JsonSerializable()
class Address {
  final String country, street, city;
  @JsonKey(name: 'zip_code')
  final int zipCode;
  final Coords coords;

  Address(
      {required this.country,
      required this.street,
      required this.city,
      required this.zipCode,
      required this.coords});
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Coords {
  final double lat, lan;
  Coords({required this.lat, required this.lan});
  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);
  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}

@JsonSerializable()
class Services {
  final List<String> free, paid;
  Services({required this.free, required this.paid});
  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}
