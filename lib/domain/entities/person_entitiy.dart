import 'package:equatable/equatable.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';

class ShortPersonEntity extends Equatable {
  final int id;
  final String url;

  ShortPersonEntity({required this.id, required this.url});

  @override
  List<Object?> get props => [id, url];
}

class PersonEntity extends ShortPersonEntity {
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final ShortLocationEntity origin;
  final ShortLocationEntity location;
  final String image;
  final List<ShortEpisodeEntity> episode;
  final DateTime created;

  PersonEntity({
    required super.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
    required super.url,
  });

  @override
  String toString() {
    return '$id,$name,${origin.toString()},$episode';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        created,
      ];
}
