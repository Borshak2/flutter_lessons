// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeDto _$EpisodeDtoFromJson(Map<String, dynamic> json) => EpisodeDto(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      name: json['name'] as String,
      airDate: json['air_date'] as String,
      episode: json['episode'] as String,
      characters: (json['characters'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EpisodeDtoToJson(EpisodeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'characters': instance.characters,
    };
