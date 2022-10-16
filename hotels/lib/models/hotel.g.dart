// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelInfo _$HotelInfoFromJson(Map<String, dynamic> json) => HotelInfo(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      poster: json['poster'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      services: Services.fromJson(json['services'] as Map<String, dynamic>),
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HotelInfoToJson(HotelInfo instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'poster': instance.poster,
      'address': instance.address,
      'price': instance.price,
      'rating': instance.rating,
      'services': instance.services,
      'photos': instance.photos,
    };

Preview _$PreviewFromJson(Map<String, dynamic> json) => Preview(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      poster: json['poster'] as String,
    );

Map<String, dynamic> _$PreviewToJson(Preview instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'poster': instance.poster,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      country: json['country'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      zipCode: json['zip_code'] as int,
      coords: Coords.fromJson(json['coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'country': instance.country,
      'street': instance.street,
      'city': instance.city,
      'zip_code': instance.zipCode,
      'coords': instance.coords,
    };

Coords _$CoordsFromJson(Map<String, dynamic> json) => Coords(
      lat: (json['lat'] as num).toDouble(),
      lan: (json['lan'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordsToJson(Coords instance) => <String, dynamic>{
      'lat': instance.lat,
      'lan': instance.lan,
    };

Services _$ServicesFromJson(Map<String, dynamic> json) => Services(
      free: (json['free'] as List<dynamic>).map((e) => e as String).toList(),
      paid: (json['paid'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
      'free': instance.free,
      'paid': instance.paid,
    };
