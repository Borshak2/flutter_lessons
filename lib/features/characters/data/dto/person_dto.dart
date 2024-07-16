import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_dto.g.dart';

@JsonSerializable()
class PersonDto extends Equatable {
  final int id;
  final String url;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  @JsonKey(name: 'origin')
  final Map<String, dynamic> origin;
  @JsonKey(name: 'location')
  final Map<String, dynamic> location;
  final String image;
  final List<String> episode;
  final DateTime created;

  String get originName => origin['name'] ?? '';
  String get originUrl => origin['url'] ?? '';
  String get locationName => location['name'] ?? '';
  String get locationUrl => location['url'] ?? '';

  PersonDto({
    required this.id,
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
    required this.url,
  });

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonDtoToJson(this);

  @override
  String toString() {
    return '$id,$name,$episode';
  }

  @override
  List<Object?> get props => [id, name];
}
