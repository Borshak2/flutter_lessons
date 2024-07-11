import 'package:equatable/equatable.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';

class ShortEpisodeEntity extends Equatable {
  final int id;
  final String url;

  ShortEpisodeEntity({required this.id, required this.url});

  @override
  List<Object?> get props => [id, url];
}

class EpisodeEntity extends ShortEpisodeEntity {
  final String name;
  final String airDate;
  final String episode;
  final List<ShortPersonEntity> characters;

  EpisodeEntity({
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required super.id,
    required super.url,
  });

 

  @override
  String toString() {
    return '$id,$name,$characters';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        episode,
      ];
}

//  factory EpisodeEntity.fromJson(Map<String, dynamic> json) {
//     List list = json['characters'];
//     return EpisodeEntity(
//         id: json['id'],
//         name: json['name'],
//         airDate: json['air_date'],
//         episode: json['episode'],
//         characters: [...list],
//         url: json['url']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'air_date': airDate,
//       'episode': episode,
//       'characters': characters,
//       'url': url,
//     };
//   }