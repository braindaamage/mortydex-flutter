import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mdx_characters/mdx_characters.dart';

import '../fixtures/entities/character_mocks.dart';
import '../fixtures/interfaces/mdx_character_data_source.mocks.dart';

void main() {
  late MockMDXCharacterCloudDataSource mockCloudDataSource;
  late MDXCharacterRepositoryImp repository;
  final mockCharacterDataGenerator = MockCharacterDataGenerator();

  setUp(() {
    mockCloudDataSource = MockMDXCharacterCloudDataSource();
    repository =
        MDXCharacterRepositoryImp(cloudDataSource: mockCloudDataSource);
  });

  final tCharacter = mockCharacterDataGenerator.getMockCharacter();
  final tCharacters = [
    tCharacter,
    mockCharacterDataGenerator.getMockCharacter()
  ];
  final tPage = mockCharacterDataGenerator.generateUniqueId();
  final tId = tCharacter.id;
  final tName = tCharacter.name;
  final tListOfIds = tCharacters.map((chharacter) => chharacter.id).toList();
  final tFilter = MDXCharacterFilter(name: tName);

  group('MDXCharacterRepositoryImp', () {
    group('Success Cases', () {
      test('should get all characters from the datasource', () async {
        // arrange
        when(mockCloudDataSource.getAllCharacters(any))
            .thenAnswer((_) async => tCharacters);
        // act
        final result = await repository.getAllCharacters(tPage);
        // assert
        expect(result, equals(tCharacters));
        verify(mockCloudDataSource.getAllCharacters(tPage));
        verifyNoMoreInteractions(mockCloudDataSource);
      });

      test('should get character by id from the datasource', () async {
        // arrange
        when(mockCloudDataSource.getCharacterById(any))
            .thenAnswer((_) async => tCharacter);
        // act
        final result = await repository.getCharacterById(tId);
        // assert
        expect(result, equals(tCharacter));
        verify(mockCloudDataSource.getCharacterById(tId));
        verifyNoMoreInteractions(mockCloudDataSource);
      });

      test('should get characters by list of ids from the datasource',
          () async {
        // arrange
        when(mockCloudDataSource.getCharactersByIds(any))
            .thenAnswer((_) async => tCharacters);
        // act
        final result = await repository.getCharactersByIds(tListOfIds);
        // assert
        expect(result, equals(tCharacters));
        verify(mockCloudDataSource.getCharactersByIds(tListOfIds));
        verifyNoMoreInteractions(mockCloudDataSource);
      });

      test('should get characters by filter from the datasource', () async {
        // arrange
        when(mockCloudDataSource.getFilteredCharacters(any))
            .thenAnswer((_) async => tCharacters);
        // act
        final result = await repository.getFilteredCharacters(tFilter);
        // assert
        expect(result, equals(tCharacters));
        verify(mockCloudDataSource.getFilteredCharacters(tFilter));
        verifyNoMoreInteractions(mockCloudDataSource);
      });
    });

    group('Throw Exceptions', () {
      test(
          'should throw an exception when there is an error getting characters from the datasource',
          () async {
        // arrange
        when(mockCloudDataSource.getAllCharacters(any)).thenThrow(Exception());

        // assert
        expect(() async => await repository.getAllCharacters(tPage),
            throwsA(isInstanceOf<Exception>()));
        verify(mockCloudDataSource.getAllCharacters(tPage));
        verifyNoMoreInteractions(mockCloudDataSource);
      });

      test(
          'should throw an exception when there is an error getting character by id from the datasource',
          () async {
        // arrange
        when(mockCloudDataSource.getCharacterById(any)).thenThrow(Exception());

        // assert
        expect(() async => await repository.getCharacterById(tId),
            throwsA(isInstanceOf<Exception>()));
        verify(mockCloudDataSource.getCharacterById(tId));
        verifyNoMoreInteractions(mockCloudDataSource);
      });

      test(
          'should throw an exception when there is an error getting characters by ids from the datasource',
          () async {
        // arrange
        when(mockCloudDataSource.getCharactersByIds(any))
            .thenThrow(Exception());

        // assert
        expect(() async => await repository.getCharactersByIds(tListOfIds),
            throwsA(isInstanceOf<Exception>()));
        verify(mockCloudDataSource.getCharactersByIds(tListOfIds));
        verifyNoMoreInteractions(mockCloudDataSource);
      });

      test(
          'should throw an exception when there is an error getting characters by filter from the datasource',
          () async {
        // arrange
        when(mockCloudDataSource.getFilteredCharacters(any))
            .thenThrow(Exception());

        // assert
        expect(() async => await repository.getFilteredCharacters(tFilter),
            throwsA(isInstanceOf<Exception>()));
        verify(mockCloudDataSource.getFilteredCharacters(tFilter));
        verifyNoMoreInteractions(mockCloudDataSource);
      });
    });
  });
}
