import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode_dto.g.dart';

@JsonSerializable()
class EpisodeDto extends Equatable {
  final int id;
  final String url;
  final String name;
  @JsonKey(name: 'air_date')
  final String airDate;
  final String episode;
  final List<String> characters;

  EpisodeDto({
    required this.id,
    required this.url,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
  });

  factory EpisodeDto.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeDtoToJson(this);

  @override
  String toString() {
    return '$id,$name,$characters';
  }

  @override
  List<Object?> get props => [id, name, characters];
}
