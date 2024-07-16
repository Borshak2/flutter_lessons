import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto extends Equatable {
  final int id;
  final String name;
  final String url;
  final String type;
  final String dimension;
  final List<String> residents;
  final String created;

  LocationDto({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.created,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);

  @override
  String toString() {
    return '$id,$name,$residents';
  }

  @override
  List<Object?> get props => [id, name];
}
