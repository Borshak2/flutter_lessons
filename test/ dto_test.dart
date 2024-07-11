import 'package:flutter_lesson_3_rick_v2/features/characters/data/dto/person_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/episodes/data/dto/episode_dto.dart';
import 'package:flutter_lesson_3_rick_v2/features/locations/data/dto/location_dto.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('DTOTest', () {
    final Map<String,dynamic> jsonPerson = {
      "id": 361,
      "name": "Toxic Rick",
      "status": "Dead",
      "species": "Humanoid",
      "type": "Rick's Toxic Side",
      "gender": "Male",
      "origin": {
        "name": "Alien Spa",
        "url": "https://rickandmortyapi.com/api/location/64"
      },
      "location": {
        "name": "Earth",
        "url": "https://rickandmortyapi.com/api/location/20"
      },
      "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
      "episode": [
        "https://rickandmortyapi.com/api/episode/27"
      ],
      "url": "https://rickandmortyapi.com/api/character/361",
      "created": "2018-01-10T18:20:41.703Z"
    };

    final Map<String,dynamic> jsonLocation = {
      "id": 1,
      "name": "Earth",
      "type": "Planet",
      "dimension": "Dimension C-137",
      "residents": [
        "https://rickandmortyapi.com/api/character/1",
        "https://rickandmortyapi.com/api/character/2",
        // ...
      ],
      "url": "https://rickandmortyapi.com/api/location/1",
      "created": "2017-11-10T12:56:36.618Z"
    };

    final Map<String,dynamic> jsonEpisode = {
      "id": 1,
      "name": "Pilot",
      "air_date": "December 2, 2013",
      "episode": "S01E01",
      "characters": [
        "https://rickandmortyapi.com/api/character/1",
        "https://rickandmortyapi.com/api/character/2",
        //...
      ],
      "url": "https://rickandmortyapi.com/api/episode/1",
    };

    test('PersonDto convert ', () async {
        final personDto = PersonDto.fromJson(jsonPerson);
        final jsonResault = personDto.toJson();
        expect(jsonResault, jsonPerson);
    });

    test('LocationDto convert ', () async {
        final locationDto = LocationDto.fromJson(jsonLocation);
        final jsonResault = locationDto.toJson();
        expect(jsonResault, jsonLocation);
    });

        test('EpisodeDto convert ', () async {
        final episodeDto = EpisodeDto.fromJson(jsonEpisode);
        final jsonResault = episodeDto.toJson();
        expect(jsonResault, jsonEpisode);
    });
  });
}

