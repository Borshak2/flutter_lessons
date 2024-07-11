import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/dto/location_dto.dart';

class LocationMapper {
  static LocationEntity toEntity(LocationDto dto) {
    return LocationEntity(
      id: dto.id,
      name: dto.name,
      type: dto.type,
      dimension: dto.dimension,
      url: dto.url,
      created: dto.created,
      residents: dto.residents
          .map((element) => ShortPersonEntity(
              id: int.parse(Uri.parse(element).pathSegments.last),
              url: element))
          .toList(),
    );
  }

  static LocationDto fromEntity(LocationEntity entity) {
    return LocationDto(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      dimension: entity.dimension,
      url: entity.url,
      created: entity.created,
      residents: entity.residents.map((element) => element.url).toList(),
    );
  }
}
