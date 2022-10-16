import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class HotelInfo {
  final Preview preview;
  final Adress adress;
  final double price;
  final double rating;
  final Services services;
  final List<String> photos;

  HotelInfo(
      {required this.preview,
      required this.adress,
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
class Adress {
  final String country, street, city;
  final int zipCode;
  final Coords coords;

  Adress(
      {required this.country,
      required this.street,
      required this.city,
      required this.zipCode,
      required this.coords});
  factory Adress.fromJson(Map<String, dynamic> json) => _$AdressFromJson(json);
  Map<String, dynamic> toJson() => _$AdressToJson(this);
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
