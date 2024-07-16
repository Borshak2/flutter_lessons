import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/location_entity.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/features/characters/data/dto/person_dto.dart';

class PersonMapper {
  static PersonEntity toEntity(PersonDto dto) {
    int originId = dto.originUrl.isNotEmpty
        ? int.parse(Uri.parse(dto.originUrl).pathSegments.last)
        : 999;
    return PersonEntity(
        id: dto.id,
        name: dto.name,
        status: dto.status,
        species: dto.species,
        type: dto.type,
        gender: dto.gender,
        origin: ShortLocationEntity(
            id: originId, name: dto.originName, url: dto.originUrl),
        location: ShortLocationEntity(
            id: 1, name: dto.locationName, url: dto.locationUrl),
        image: dto.image,
        episode: dto.episode
            .map((element) => ShortEpisodeEntity(
                id: int.parse(Uri.parse(element).pathSegments.last),
                url: element))
            .toList(),
        created: dto.created,
        url: dto.url);
  }

  static PersonDto fromEntity(PersonEntity entity) {
    return PersonDto(
        id: entity.id,
        name: entity.name,
        status: entity.status,
        species: entity.species,
        type: entity.type,
        gender: entity.gender,
        origin: <String, dynamic>{
          'name': entity.origin.name,
          'url': entity.origin.url,
        },
        location: <String, dynamic>{
          'name': entity.location.name,
          'url': entity.location.url,
        },
        image: entity.image,
        episode: entity.episode.map((element) => element.url).toList(),
        created: entity.created,
        url: entity.url);
  }
}
