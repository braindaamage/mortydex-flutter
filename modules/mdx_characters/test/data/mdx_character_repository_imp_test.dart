import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/mockito.dart';

import './data_mockito_generator.mocks.dart';

void main() {
  late MockMDXCharacterDataSource mockDataSource;
  late MDXCharacterRepositoryImp repository;

  setUp(() {
    mockDataSource = MockMDXCharacterDataSource();
    repository = MDXCharacterRepositoryImp(dataSource: mockDataSource);
  });

  const tPage = 1;
  const tId = 1;
  const tName = 'Test Character';
  const tListOfIds = [tId];
  const tFilter = MDXCharacterFilter(name: tName);
  final tCharacter = MDXCharacter(
    id: tId,
    name: tName,
    status: MDXCharacterStatus.alive,
    species: 'Human',
    type: 'Normal',
    gender: MDXCharacterGender.male,
    imageUrl: 'https://test.com/image.png',
    created: DateTime.now(),
  );
  final tCharacters = [
    tCharacter,
  ];

  group('Success Cases', () {
    test('should get all characters from the datasource', () async {
      // arrange
      when(mockDataSource.getAllCharacters(any))
          .thenAnswer((_) async => tCharacters);
      // act
      final result = await repository.getAllCharacters(tPage);
      // assert
      expect(result, equals(tCharacters));
      verify(mockDataSource.getAllCharacters(tPage));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should get character by id from the datasource', () async {
      // arrange
      when(mockDataSource.getCharacterById(any))
          .thenAnswer((_) async => tCharacter);
      // act
      final result = await repository.getCharacterById(tId);
      // assert
      expect(result, equals(tCharacter));
      verify(mockDataSource.getCharacterById(tId));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should get characters by list of ids from the datasource', () async {
      // arrange
      when(mockDataSource.getCharactersByIds(any))
          .thenAnswer((_) async => tCharacters);
      // act
      final result = await repository.getCharactersByIds(tListOfIds);
      // assert
      expect(result, equals(tCharacters));
      verify(mockDataSource.getCharactersByIds(tListOfIds));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should get characters by filter from the datasource', () async {
      // arrange
      when(mockDataSource.getFilteredCharacters(any))
          .thenAnswer((_) async => tCharacters);
      // act
      final result = await repository.getFilteredCharacters(tFilter);
      // assert
      expect(result, equals(tCharacters));
      verify(mockDataSource.getFilteredCharacters(tFilter));
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('Throw Exceptions', () {
    test(
        'should throw an exception when there is an error getting characters from the datasource',
        () async {
      // arrange
      when(mockDataSource.getAllCharacters(any)).thenThrow(Exception());

      // assert
      expect(() async => await repository.getAllCharacters(tPage),
          throwsA(isInstanceOf<Exception>()));
      verify(mockDataSource.getAllCharacters(tPage));
      verifyNoMoreInteractions(mockDataSource);
    });

    test(
        'should throw an exception when there is an error getting character by id from the datasource',
        () async {
      // arrange
      when(mockDataSource.getCharacterById(any)).thenThrow(Exception());

      // assert
      expect(() async => await repository.getCharacterById(tId),
          throwsA(isInstanceOf<Exception>()));
      verify(mockDataSource.getCharacterById(tId));
      verifyNoMoreInteractions(mockDataSource);
    });

    test(
        'should throw an exception when there is an error getting characters by ids from the datasource',
        () async {
      // arrange
      when(mockDataSource.getCharactersByIds(any)).thenThrow(Exception());

      // assert
      expect(() async => await repository.getCharactersByIds(tListOfIds),
          throwsA(isInstanceOf<Exception>()));
      verify(mockDataSource.getCharactersByIds(tListOfIds));
      verifyNoMoreInteractions(mockDataSource);
    });

    test(
        'should throw an exception when there is an error getting characters by filter from the datasource',
        () async {
      // arrange
      when(mockDataSource.getFilteredCharacters(any)).thenThrow(Exception());

      // assert
      expect(() async => await repository.getFilteredCharacters(tFilter),
          throwsA(isInstanceOf<Exception>()));
      verify(mockDataSource.getFilteredCharacters(tFilter));
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
