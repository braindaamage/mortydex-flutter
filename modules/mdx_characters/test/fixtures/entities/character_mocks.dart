import 'package:faker/faker.dart';
import 'dart:math';

import 'package:mdx_characters/mdx_characters.dart';

class MockCharacterDataGenerator {
  final Faker _faker = Faker();
  final Random _random = Random();
  final Set<int> _usedIds = {};

  MDXCharacter getMockCharacter([int? tId]) {
    int id = tId ?? generateUniqueId();

    return MDXCharacter(
      id: id,
      name: faker.person.name(),
      status: MDXCharacterStatus
          .values[_random.nextInt(MDXCharacterStatus.values.length)],
      species: 'Human',
      type: 'Normal',
      gender: MDXCharacterGender
          .values[_random.nextInt(MDXCharacterGender.values.length)],
      imageUrl: faker.internet.httpUrl(),
      created: faker.date.dateTime(),
    );
  }

  int generateUniqueId() {
    int id = _faker.randomGenerator.integer(1000);
    while (_usedIds.contains(id)) {
      id = _faker.randomGenerator.integer(1000);
    }
    _usedIds.add(id);
    return id;
  }
}
