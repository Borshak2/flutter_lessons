import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_rick_v2/common/components/image.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/episode_entitiy.dart';
import 'package:flutter_lesson_3_rick_v2/domain/entities/person_entitiy.dart';

import '../../../../../common/app_colors.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ImageCommon(width: 166, height: 166, url: person.image),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive'
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  person.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            if (person.type.isNotEmpty)
              ...buildText('Type:', person.type),
            ...buildText('Gender:', person.gender),
            ...buildText('Number of episodes: ',
                person.episode.length.toString()),
            ...buildText('Species:', person.species),
            ...buildText('Last known location:', person.location.name),
            ...buildText('Origin:', person.origin.name),
            ...buildText('Was created:', person.created.toString()),
            const SizedBox(
              height: 16,
            ),
            // const Text(
            //   'Episodes',
            //   style: TextStyle(
            //     color: AppColors.greyColor,
            //   ),
            // ),
            // BlocBuilder<PersonListCubit, PersonListState>(
            //     buildWhen: (previous, current) =>
            //         current.page == PageAdreess.detail,
            //     builder: (context,state){
            //       return SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            // child: Row(children: state.episodes.map((episode) => containerText(episode)).toList(),));
            //       // ListView(
            //       //   scrollDirection: Axis.horizontal,
            //       //   children: state.episodes.map((episode) => containerText(episode)).toList(),
            //       // );
            //     }),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(
          color: AppColors.greyColor,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}

Widget containerText(EpisodeEntity episode) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(
          'Name',
          style: const TextStyle(
            color: AppColors.greyColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          episode.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          'air-date',
          style: const TextStyle(
            color: AppColors.greyColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          episode.airDate,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
