import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/dto/episode_dto.dart';

class EpisodeMapper {
 static EpisodeEntity toEntity(EpisodeDto dto) {
    return EpisodeEntity(
        name: dto.name,
        airDate: dto.airDate,
        episode: dto.episode,
        characters: dto.characters
            .map((element) => ShortPersonEntity(id: int.parse(Uri.parse(element).pathSegments.last), url: element))
            .toList(),
        id: dto.id,
        url: dto.url);
  }

 static EpisodeDto fromEntity(EpisodeEntity entity) {
    return EpisodeDto(
        name: entity.name,
        airDate: entity.airDate,
        episode: entity.episode,
        characters: entity.characters.map((element) => element.url).toList(),
        id: entity.id,
        url: entity.url);
  }
}
