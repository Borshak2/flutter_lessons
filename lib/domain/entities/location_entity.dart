import 'package:equatable/equatable.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';

class ShortLocationEntity extends Equatable {
  final int id;
  final String name;
  final String url;

  ShortLocationEntity(
      {required this.id, required this.name, required this.url});

  @override
  List<Object?> get props => [id, name, url];
}

class LocationEntity extends ShortLocationEntity {
  final String type;
  final String dimension;
  final List<ShortPersonEntity> residents;

  final String created;

  LocationEntity(
      {required super.id,
      required super.name,
      required this.type,
      required this.dimension,
      required super.url,
      required this.created,
      required this.residents});

  @override
  String toString() {
    return '$id,$name,$residents';
  }

  @override
  List<Object?> get props => [id, name, type];
}

// factory LocationEntity.fromJson(Map<String, dynamic> json) {
//   List list = json['residents'];
//   return LocationEntity(
//       id: json['id'],
//       name: json['name'],
//       type: json['type'],
//       dimension: json['dimension'],
//       url: json['url'],
//       created: json['created'],
//       residents: [...list],
//       );
// }

// Map<String, dynamic> toJson() {
//   return {
//     'id': id,
//     'name': name,
//     'type': type,
//     'dimension': dimension,
//     'residents': residents,
//     'url': url,
//     'created': created,
//   };
// }
